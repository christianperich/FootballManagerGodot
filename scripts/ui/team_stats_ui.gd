extends VBoxContainer

const TEAM_STATS = preload("uid://cqbc4lb12uov6")
const GROUP_HEADERS = preload("uid://brnde8v7qob5y")


func _ready() -> void:
	get_stats()

func get_stats():
	for child in get_children():
		child.queue_free()
	
	var groups: Dictionary = GameManager.groups
	var group_id = 0
	for group in groups:
		#Conseguir datos del grupo
		var group_table = GameManager.get_group_table(group_id)
		
		#Crear Título del grupo
		var group_title = RichTextLabel.new()
		group_title.text = "[b]Grupo " + str(group_id + 1) + "[/b]"
		group_title.bbcode_enabled = true # Activamos BBCode para que se aplique la negrita
		group_title.fit_content = true
		
		#crea margen entre grupos
		if group_id > 0:
			var spacer = Control.new()
			spacer.custom_minimum_size = Vector2(0, 20)
			add_child(spacer)
		
		add_child(group_title)
		
		#crea los headers de cada grupo
		var group_headers = GROUP_HEADERS.instantiate()
		add_child(group_headers)
		
		#actualiza las stats
		var position_number = 1
		
		for stat in group_table:
			var stats = TEAM_STATS.instantiate()
			add_child(stats)

			#label de posición						
			var position_label: RichTextLabel = stats.find_child("PositionLabel")
			position_label.text = str(position_number)
			position_number += 1

			#label de equipo			
			var team_name: RichTextLabel = stats.find_child("TeamNameLabel")
			if team_name:
				team_name.text = stat.team_data.name
			else:
				print("Advertencia: No se encontró 'TeamNameLabel' dentro de la escena TEAM_STATS")
			
			#label de puntos
			var team_points: RichTextLabel = stats.find_child("TeamPoints")
			team_points.text = str(stat.points)

			#label de victorias
			var team_wins: RichTextLabel = stats.find_child("TeamPG")
			team_wins.text = str(stat.wins)

			#label de empates
			var team_draws: RichTextLabel = stats.find_child("TeamPE")
			team_draws.text = str(stat.draws)
			
			#label de derrotas
			var team_losses: RichTextLabel = stats.find_child("TeamPP")
			team_losses.text = str(stat.losses)

			#label de goles a favor
			var team_goals_for: RichTextLabel = stats.find_child("TeamGF")
			team_goals_for.text = str(stat.goals_for)

			#label de goles en contra
			var team_goals_against: RichTextLabel = stats.find_child("TeamGC")
			team_goals_against.text = str(stat.goals_against)

			#label de diferencia de goles
			var team_goal_difference: RichTextLabel = stats.find_child("TeamDG")
			team_goal_difference.text = str(stat.get_goal_difference())

			#label de partidos jugados
			var team_matches_played: RichTextLabel = stats.find_child("TeamPJ")
			team_matches_played.text = str(stat.matches_played)
			
		group_id += 1
