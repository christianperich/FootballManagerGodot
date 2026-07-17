class_name MatchEvent
extends RefCounted

enum EventType {
	CHANCE,
	SHOT,
	GOAL,
	YELLOW_CARD,
	RED_CARD,
	INJURY,
	SUBSTITUTION
}

var minute: int = 0

var attacking_team: TeamData
var defending_team: TeamData

var type: EventType
