extends Node

var match_date = 1
var actual_date = 1

var all_teams : Array[TeamData] = []
var all_matches : Array[MatchData] = []
var groups : Dictionary = {}
var stats_lookup : Dictionary = {}



func _ready() -> void:
	all_teams = load_all_teams()
	create_groups(4)
	create_fixture()
	
	
func load_all_teams() -> Array[TeamData]:
	var lista_equipos: Array[TeamData] = []
	var ruta_carpeta = "res://resources/teams/" 
	var dir = DirAccess.open(ruta_carpeta)
	
	if dir:
		dir.list_dir_begin()
		var nombre_archivo = dir.get_next()
		
		while nombre_archivo != "":
			if not dir.current_is_dir():
				if nombre_archivo.ends_with(".tres") or nombre_archivo.ends_with(".res") or nombre_archivo.ends_with(".remap"):
					var ruta_completa = ruta_carpeta + nombre_archivo
					ruta_completa = ruta_completa.trim_suffix(".remap") 
	
					var recurso = load(ruta_completa)
					if recurso is TeamData:
						lista_equipos.append(recurso)
			
			nombre_archivo = dir.get_next()
			
		dir.list_dir_end()
	else:
		print("Error: No se pudo abrir la ruta: ", ruta_carpeta)
		
	return lista_equipos
	
func create_groups(teams_per_group: int = 4) -> void:
	all_teams.shuffle()
	groups.clear()
	stats_lookup.clear()
	
	var num_teams = all_teams.size()
	var num_groups = num_teams / teams_per_group
	
	# Inicializamos los grupos vacíos
	for i in range(num_groups):
		var group_teams: Array[TeamStats] = []
		groups[i] = group_teams
	
	# Repartimos y envolvemos cada TeamData en un TeamStats
	for i in range(num_teams):
		var group_index = i % num_groups
		var team_data = all_teams[i]
		
		# Instanciamos la clase de estadísticas temporales
		var team_stats = TeamStats.new(team_data)
		
		groups[group_index].append(team_stats)
		stats_lookup[team_data] = team_stats
		
	#_print_groups()
	

"""func _print_groups() -> void:
	for group_id in groups.keys():
		var names = []
		for team in groups[group_id]:
			names.append(team.name)
		print("Grupo ", group_id + 1, ": ", names)"""

func create_fixture() -> void:
	all_matches.clear()

	for group_id in groups.keys():
		var group_teams: Array[TeamStats] = groups[group_id]
		_generate_round_robin_fixture(group_teams, group_id)
		
	print("Total de partidos creados en el torneo: " + str(all_matches.size()))


func _generate_round_robin_fixture(group_teams: Array[TeamStats], group_id: int) -> void:
	if group_teams.size() < 2:
		return
		
	var teams = group_teams.duplicate()
	
	if teams.size() % 2 != 0:
		print("Advertencia: El grupo ", group_id + 1, " tiene equipos impares. Se recomienda que sean pares.")
		# Podrías manejar un 'dummy' team aquí si lo necesitas.

	var num_teams = teams.size()
	var total_rounds = num_teams - 1
	var matches_per_round = num_teams / 2

	for round_num in range(total_rounds):
		var current_round_date = round_num + 1 
		
		for match_num in range(matches_per_round):
			var home_idx = (round_num + match_num) % (num_teams - 1)
			var away_idx = (num_teams - 1 - match_num + round_num) % (num_teams - 1)
			
			# El último equipo se queda fijo en su posición para que la rotación funcione
			if match_num == 0:
				away_idx = num_teams - 1
				
			var team_home = teams[home_idx].team_data
			var team_away = teams[away_idx].team_data
			
			setup_match(team_home, team_away, current_round_date, group_id)



func setup_match(team1: TeamData, team2: TeamData, date: int, group_id: int) -> void:
	var partido = MatchData.new()
	partido.team1 = team1
	partido.team2 = team2
	partido.match_number = date # Usamos la jornada calculada dinámicamente
	
	partido.group_id = group_id 
	
	all_matches.append(partido)
	
	print("Grupo %d | Jornada %d: %s vs %s" % [group_id + 1, date, team1.name, team2.name])

	
func avanzar_jornada():
	actual_date += 1

# Registra el resultado de un partido y actualiza las tablas
func register_match_result(match_data: MatchData, goals_team1: int, goals_team2: int) -> void:
	# Buscamos las estadísticas de los dos equipos
	var stats1: TeamStats = stats_lookup[match_data.team1]
	var stats2: TeamStats = stats_lookup[match_data.team2]
	
	# Actualizamos partidos jugados y goles
	stats1.matches_played += 1
	stats2.matches_played += 1
	
	stats1.goals_for += goals_team1
	stats1.goals_against += goals_team2
	
	stats2.goals_for += goals_team2
	stats2.goals_against += goals_team1
	
	# Asignamos puntos según el resultado
	if goals_team1 > goals_team2:
		stats1.points += 3
		stats1.wins += 1
		stats2.losses += 1
	elif goals_team2 > goals_team1:
		stats2.points += 3
		stats2.wins += 1
		stats1.losses += 1
	else:
		stats1.points += 1
		stats2.points += 1
		stats1.draws += 1
		stats2.draws += 1
		
		
# Devuelve la tabla de posiciones de un grupo ordenante de mejor a peor
func get_group_table(group_id: int) -> Array[TeamStats]:
	if not groups.has(group_id):
		return []
		
	var table: Array[TeamStats] = groups[group_id].duplicate()
	
	# Usamos un comparador personalizado para ordenar la tabla
	table.sort_custom(func(a: TeamStats, b: TeamStats) -> bool:
		# 1. Comparar por puntos
		if a.points != b.points:
			return a.points > b.points # Mayor puntaje va primero
			
		# 2. Desempate por diferencia de goles
		var diff_a = a.get_goal_difference()
		var diff_b = b.get_goal_difference()
		if diff_a != diff_b:
			return diff_a > diff_b
			
		# 3. Desempate por goles a favor
		if a.goals_for != b.goals_for:
			return a.goals_for > b.goals_for
			
		# 4. Si todo es igual, orden alfabético del nombre del recurso
		return a.team_data.name < b.team_data.name
	)
	
	return table

#obtener los clasificados (los 2 mejores de un grupo)
func get_group_qualifiers(group_id: int, spots: int = 2) -> Array[TeamStats]:
	var ordered_table = get_group_table(group_id)
	var qualifiers: Array[TeamStats] = []
	
	for i in range(min(spots, ordered_table.size())):
		qualifiers.append(ordered_table[i])
		
	return qualifiers
