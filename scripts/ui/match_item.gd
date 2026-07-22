extends PanelContainer


@onready var home_container: HBoxContainer = $MarginContainer/HBoxContainer/HomeContainer
@onready var home_team_button: Button = $MarginContainer/HBoxContainer/HomeContainer/TeamButton
	
@onready var away_container: HBoxContainer = $MarginContainer/HBoxContainer/AwayContainer
@onready var away_team_button: Button = $MarginContainer/HBoxContainer/AwayContainer/TeamButton2

@onready var score_button: Button = $MarginContainer/HBoxContainer/CenterContainer/ScoreButton

func setup(game: MatchData) -> void:
	home_team_button.text = game.home_team.name
	away_team_button.text = game.away_team.name
	score_button.text = "%s - %s" % [game.home_goals, game.away_goals]
