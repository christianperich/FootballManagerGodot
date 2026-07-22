class_name LeagueTableRow
extends Control

@onready var position_label: Label = $HBoxContainer/PositionLabel
@onready var team_label: Label = $HBoxContainer/TeamLabel
@onready var points_label: Label = $HBoxContainer/PointsLabel
@onready var logo: TextureRect = $HBoxContainer/Logo
@onready var games_played_label: Label = $HBoxContainer/GamesPlayedLabel


func setup(team_position: int, stats: TeamStanding) -> void:
	position_label.text = "%s." % str(team_position)
	team_label.text = stats.team.name
	points_label.text = str(stats.points)
	games_played_label.text = str(GameManager.current_season.current_matchday)

		# logo.texture = team.logo

func create_header():
	position_label.text = ""
	team_label.text = "EQUIPO"
	points_label.text = "PTS"
	games_played_label.text = "PJ"
	logo.texture = null
