class_name TeamStats
extends RefCounted

var team_data: TeamData

var points: int = 0
var matches_played: int = 0
var wins: int = 0
var draws: int = 0
var losses: int = 0
var goals_for: int = 0
var goals_against: int = 0

# La diferencia de goles es clave para desempatar
func get_goal_difference() -> int:
	return goals_for - goals_against

# Constructor para inicializarlo fácilmente
func _init(p_team_data: TeamData) -> void:
	team_data = p_team_data
