extends Node


var match_simulator := MatchSimulator.new()


const TOTAL_SEASONS := 1000


var champions := {}
var relegated := {}

var position_history := {}
var points_history := {}
var goals_for_history := {}
var goals_against_history := {}

var podiums := {}

var best_season := {}
var worst_season := {}


func _ready():
	run_simulation()


func run_simulation():
	var competition = load(
		"res://resources/competitions/chile_primera_a.tres"
	)


	initialize_stats(competition)


	for season_number in range(1, TOTAL_SEASONS + 1):
		print("==============================")
		print("SIMULANDO TEMPORADA ", season_number)
		print("==============================")


		var season: SeasonData = create_season(
			competition
		)


		simulate_season(
			season
		)


		save_results(
			season
		)


	print_summary()


# ====================================
# Inicializar estadísticas
# ====================================

func initialize_stats(competition):
	for team in competition.teams:
		var name = team.name


		position_history[name] = 0
		points_history[name] = 0
		goals_for_history[name] = 0
		goals_against_history[name] = 0

		podiums[name] = 0

		best_season[name] = 99
		worst_season[name] = 0


# ====================================
# Crear temporada
# ====================================

func create_season(base_competition):
	var season := SeasonData.new()

	season.start(
		base_competition.duplicate(true)
	)

	return season


# ====================================
# Simular temporada
# ====================================

func simulate_season(season):
	while true:
		var matchday = season.get_current_matchday()


		if matchday == null:
			break


		for game in matchday.matches:
			var result = match_simulator.simulate(
				game.home_team,
				game.away_team
			)


			game.home_goals = result.home_goals
			game.away_goals = result.away_goals
			game.played = true


			season.league_table.update(
				game
			)


		season.next_matchday()


# ====================================
# Guardar resultados
# ====================================

func save_results(season):
	var table = season.league_table.standings


	var champion = table[0].team.name


	if champions.has(champion):
		champions[champion] += 1
	else:
		champions[champion] = 1


	for i in range(table.size()):
		var standing = table[i]

		var name = standing.team.name

		var position = i + 1


		# Posición acumulada

		position_history[name] += position


		# Puntos

		points_history[name] += standing.points


		# Goles

		goals_for_history[name] += standing.goals_for

		goals_against_history[name] += standing.goals_against


		# Top 3

		if position <= 3:
			podiums[name] += 1


		# Mejor temporada

		if position < best_season[name]:
			best_season[name] = position


		# Peor temporada

		if position > worst_season[name]:
			worst_season[name] = position


	# Descensos

	for i in range(table.size() - 3, table.size()):
		var team = table[i].team.name


		if relegated.has(team):
			relegated[team] += 1
		else:
			relegated[team] = 1


# ====================================
# Informe final
# ====================================

func print_summary():
	print("")
	print("==============================")
	print("RESUMEN ", TOTAL_SEASONS, " TEMPORADAS")
	print("==============================")


	print_champions()

	print_relegations()

	print_average_positions()

	print_team_statistics()


# ====================================
# Campeones
# ====================================

func print_champions():
	print("")
	print("CAMPEONES")
	print("----------------")


	for team in champions:
		print(
			team,
			": ",
			champions[team],
			" (",
			float(champions[team]) / TOTAL_SEASONS * 100,
			"%)"
		)


# ====================================
# Descensos
# ====================================

func print_relegations():
	print("")
	print("DESCENSOS")
	print("----------------")


	for team in relegated:
		print(
			team,
			": ",
			relegated[team]
		)


# ====================================
# Posición promedio
# ====================================

func print_average_positions():
	print("")
	print("POSICION PROMEDIO")
	print("----------------")


	var teams = position_history.keys()


	teams.sort_custom(
		func(a, b):
			return position_history[a] < position_history[b]
	)


	for team in teams:
		var avg = float(position_history[team]) / TOTAL_SEASONS


		print(
			team,
			": ",
			round(avg * 100) / 100.0
		)


# ====================================
# Estadísticas generales
# ====================================

func print_team_statistics():
	print("")
	print("ESTADISTICAS GENERALES")
	print("----------------")


	for team in position_history:
		print("")
		print(team)


		print(
			" Puntos promedio: ",
			round(
				float(points_history[team]) / TOTAL_SEASONS
			)
		)


		print(
			" GF promedio: ",
			round(
				float(goals_for_history[team]) / TOTAL_SEASONS
			)
		)


		print(
			" GC promedio: ",
			round(
				float(goals_against_history[team]) / TOTAL_SEASONS
			)
		)


		print(
			" Top 3: ",
			podiums[team]
		)


		print(
			" Mejor puesto: ",
			best_season[team]
		)


		print(
			" Peor puesto: ",
			worst_season[team]
		)
