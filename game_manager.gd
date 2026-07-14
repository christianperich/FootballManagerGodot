extends Node

var all_teams : Array[TeamData] = []
var all_matches : Array[MatchData] = []

func _ready() -> void:
	all_teams = load_all_teams()
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
	
func create_fixture():
	#jornada 1
	print("*** Jornada 1 ***")
	setup_match(all_teams[0], all_teams[1])
	setup_match(all_teams[2], all_teams[3])
	print("")
	
	#jornada 2
	print("*** Jornada 2 ***")
	setup_match(all_teams[2], all_teams[0])
	setup_match(all_teams[1], all_teams[3])
	print("")
	
	#jornada 3
	print("*** Jornada 3 ***")
	setup_match(all_teams[0], all_teams[3])
	setup_match(all_teams[1], all_teams[2])
	print("")
	
	print("Partidos creados: " + str(all_matches.size()))

func setup_match(team1:TeamData, team2:TeamData):
	var partido = MatchData.new()
	partido.team1 = team1
	partido.team2 = team2
	all_matches.append(partido)
	print("Partido Creado: " + team1.name + " - " + team2.name)
