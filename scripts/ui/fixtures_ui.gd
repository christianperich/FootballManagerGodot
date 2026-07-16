extends VBoxContainer

@onready var fixture_container: VBoxContainer = %FixtureContainer
@onready var jornada_title: RichTextLabel = %JornadaTitle
@onready var match_simulation: Node = %MatchSimulation
@onready var group_stats_ui: VBoxContainer = $"../GroupStatsUI"

const MATCH_CONTAINER = preload("uid://c5f2ume4rkgda")
var matches_today : Array[MatchData]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	show_matches_today()
	
func show_matches_today():
	jornada_title.text = "Partido " + str(GameManager.actual_date)
	var actual_date = GameManager.actual_date	
	matches_today.clear()
	
	for child in fixture_container.get_children():
			child.queue_free()
		
	for partido in GameManager.all_matches:
		if partido.match_number == actual_date:
			matches_today.append(partido)
			setup_match(partido)
			
func setup_match(partido:MatchData):	
	var match_container = MATCH_CONTAINER.instantiate()
	fixture_container.add_child(match_container)
	
	var team1 : Button = match_container.find_child("Team1")
	team1.text = partido.team1.name
	
	var team2 : Button = match_container.find_child("Team2")
	team2.text = partido.team2.name
	
	var result : Button = match_container.find_child("Result")
	partido.set_meta("result_button", result)
	
	var group_button : Button = match_container.find_child("GroupBtn")
	group_button.text = "Grupo " + str(partido.group_id + 1)
	
	if partido.is_played:
		result.text = str(partido.goals1) + " - " + str(partido.goals2)
		result.disabled = false # Ahora lo dejamos activo para ver detalles más adelante
	else:
		result.text = "-"
		# Conectamos el botón para el futuro visor de detalles (opcional por ahora)
		result.pressed.connect(func(): _on_result_pressed(partido))
		
	if partido.is_played:
		result.disabled = true
	else:
		result.disabled = false
		#result.pressed.connect(func(): _on_result_pressed(partido, result))
		
func _on_result_pressed(partido: MatchData):
	if partido.is_played:
		print("Abriendo detalles del partido: ", partido.team1.name, " vs ", partido.team2.name)
	else:
		print("El partido aún no se ha jugado.")
	
func _on_continuar_pressed() -> void:
	if matches_today.is_empty():
		print("No hay partidos programados para hoy.")
		return

	var hay_partidos_pendientes : bool = false
	for partido in matches_today:
		if not partido.is_played:
			hay_partidos_pendientes = true
			break

	if hay_partidos_pendientes:
		for partido in matches_today:
			if not partido.is_played:
				match_simulation.simulate_match(partido)
				
				if partido.has_meta("result_button"):
					var boton_resultado : Button = partido.get_meta("result_button")
					boton_resultado.text = str(partido.goals1) + " - " + str(partido.goals2)
				
				partido.is_played = true
		
		group_stats_ui.get_stats()
		
	else:
		var group_table = GameManager.get_group_table(0)
		for stat in group_table:
			print(stat.team_data.name + " - Puntos: " + str(stat.points) + " DG: " + str(stat.get_goal_difference()))
		print("No quedan partidos por jugar hoy. ¡Avanzando a la siguiente jornada!")
	
		GameManager.avanzar_jornada()
		show_matches_today()
