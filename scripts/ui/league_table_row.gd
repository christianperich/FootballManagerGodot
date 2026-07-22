class_name LeagueTableRow
extends Control

@onready var position_label: Label = $HBoxContainer/PositionLabel
@onready var team_label: Label = $HBoxContainer/TeamLabel
@onready var points_label: Label = $HBoxContainer/PointsLabel
@onready var logo: TextureRect = $HBoxContainer/Logo


func setup(team_position: int, stats: TeamStanding) -> void:
	position_label.text = str(team_position)
	team_label.text = stats.team.name
	points_label.text = str(stats.points)

		# logo.texture = team.logo
