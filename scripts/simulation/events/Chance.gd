class_name ChanceEvent
extends MatchEvent

enum ChanceType {
	NORMAL,
	COUNTER_ATTACK,
	CORNER,
	FREE_KICK,
	PENALTY
}

# Tipo de ocasión
var chance_type: ChanceType = ChanceType.NORMAL

var danger: float = 0.0

# Si la ocasión terminó en un remate, aquí se almacena
var shot: ShotEvent = null



func _init():
	type = EventType.CHANCE
