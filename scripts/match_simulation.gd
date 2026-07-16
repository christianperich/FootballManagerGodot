extends Node


func simulate_match(partido: MatchData):
	partido.goals1 = randi_range(0,3)
	partido.goals2 = randi_range(0,3)
	
	GameManager.register_match_result(partido, partido.goals1, partido.goals2)
