extends Control

@onready var matchday_screen: Control = $Content/MatchdayScreen

func _on_continue_button_pressed() -> void:
	GameManager.play_current_matchday()
	
	matchday_screen.show_league_table()
	matchday_screen.show_results()

	GameManager.current_season.next_matchday()
