extends PanelContainer


@onready var home_container: HBoxContainer = $MarginContainer/HBoxContainer/HomeContainer
@onready var home_label: Label = $MarginContainer/HBoxContainer/HomeContainer/Label
	
@onready var away_container: HBoxContainer = $MarginContainer/HBoxContainer/AwayContainer
@onready var away_label: Label = $MarginContainer/HBoxContainer/AwayContainer/Label

@onready var score_label: Label = $MarginContainer/HBoxContainer/CenterContainer/ScoreLabel

func setup(game: MatchData) -> void:
	home_label.text = game.home_team.name
	away_label.text = game.away_team.name
	score_label.text = "%s - %s" % [game.home_goals, game.away_goals]