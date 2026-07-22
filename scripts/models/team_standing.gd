class_name TeamStanding
extends RefCounted

var team: TeamData

var played := 0
var wins := 0
var draws := 0
var losses := 0

var goals_for := 0
var goals_against := 0

var points := 0

func goal_difference() -> int:
	return goals_for - goals_against