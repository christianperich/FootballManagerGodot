class_name FormationSlot
extends Resource

@export var position: PlayerData.Position

@export_range(0, 100)
var x := 50.0

@export_range(0, 100)
var y := 50.0

static func create_slot(
	player_position: PlayerData.Position,
	pos_x: float,
	pos_y: float
) -> FormationSlot:
	var slot := FormationSlot.new()

	slot.position = player_position
	slot.x = pos_x
	slot.y = pos_y

	return slot
