class_name GoalEvent
extends MatchEvent


var shot: ShotEvent

var scorer: PlayerData
var assist: PlayerData
var goalkeeper: PlayerData

func _init():
	type = EventType.GOAL
