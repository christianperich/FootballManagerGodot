class_name PlayerData
extends Resource

enum Position {
	GK,
	LB,
	SW,
	CB,
	RB,
	CDM,
	CM,
	CAM,
	LM,
	RM,
	LW,
	RW,
	FW,
	ST
}

enum Foot {
	RIGHT,
	LEFT,
	BOTH
}

#region player attributes
@export_category("Información")
@export var id: int = -1
@export var first_name: String
@export var last_name: String
@export var nickname: String
@export var age: int = 20
@export var nationality: NationalityData
@export var primary_position: Position
@export var secondary_positions: Array[Position] = []
@export var preferred_foot := Foot.RIGHT

@export_category("Atributos")
@export_range(1, 100) var pace := 50
@export_range(1, 100) var shooting := 50
@export_range(1, 100) var passing := 50
@export_range(1, 100) var dribbling := 50
@export_range(1, 100) var defending := 50
@export_range(1, 100) var physical := 50
@export_range(1, 100) var goalkeeping := 50
@export_range(1, 100) var potential := 70
#endregion

func get_full_name() -> String:
	if not nickname.is_empty():
		return nickname

	return "%s %s" % [first_name, last_name]

func get_short_name() -> String:
	if not nickname.is_empty():
		return nickname
	elif not first_name.is_empty() and last_name.is_empty():
		return first_name
	elif first_name.is_empty() and not last_name.is_empty():
		return last_name
	else:
		return "%s. %s" % [first_name.left(1), last_name]

func get_rating_for_position(position: Position) -> float:
	match position:
		Position.GK:
			return (
				goalkeeping * 0.75 +
				passing * 0.10 +
				physical * 0.10 +
				pace * 0.05
			)

		Position.LB, Position.RB:
			return (
				defending * 0.35 +
				pace * 0.25 +
				passing * 0.20 +
				physical * 0.10 +
				dribbling * 0.10
			)

		Position.SW:
			return (
				defending * 0.40 +
				passing * 0.25 +
				physical * 0.15 +
				pace * 0.10 +
				dribbling * 0.10
			)

		Position.CB:
			return (
				defending * 0.45 +
				physical * 0.25 +
				pace * 0.15 +
				passing * 0.10 +
				dribbling * 0.05
			)

		Position.CDM:
			return (
				defending * 0.30 +
				passing * 0.30 +
				physical * 0.20 +
				dribbling * 0.10 +
				pace * 0.10
			)

		Position.CM:
			return (
				passing * 0.35 +
				dribbling * 0.20 +
				physical * 0.15 +
				pace * 0.15 +
				defending * 0.10 +
				shooting * 0.05
			)

		Position.CAM:
			return (
				passing * 0.35 +
				dribbling * 0.30 +
				shooting * 0.20 +
				pace * 0.10 +
				physical * 0.05
			)

		Position.LM, Position.RM:
			return (
				pace * 0.30 +
				dribbling * 0.25 +
				passing * 0.25 +
				physical * 0.10 +
				shooting * 0.05 +
				defending * 0.05
			)

		Position.LW, Position.RW:
			return (
				dribbling * 0.35 +
				pace * 0.30 +
				shooting * 0.20 +
				passing * 0.10 +
				physical * 0.05
			)

		Position.FW:
			return (
				shooting * 0.30 +
				dribbling * 0.25 +
				passing * 0.20 +
				pace * 0.15 +
				physical * 0.10
			)

		Position.ST:
			return (
				shooting * 0.40 +
				physical * 0.20 +
				pace * 0.20 +
				dribbling * 0.15 +
				passing * 0.05
			)

	return 0

static func position_to_string(position: Position) -> String:
	return Position.keys()[position]
