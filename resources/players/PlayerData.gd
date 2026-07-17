class_name PlayerData
extends Resource

enum Position {
	GK,
	LB,
	CB,
	RB,
	CDM,
	CM,
	CAM,
	LW,
	RW,
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

@export_range(1, 100)
var pace := 50

@export_range(1, 100)
var shooting := 50

@export_range(1, 100)
var passing := 50

@export_range(1, 100)
var dribbling := 50

@export_range(1, 100)
var defending := 50

@export_range(1, 100)
var physical := 50

@export_range(1, 100)
var goalkeeping := 50

@export_range(1, 100)
var potential := 70
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

func get_rating_for_position(target_position: Position) -> float:
	match target_position:
		Position.GK:
			return goalkeeping

		Position.CB:
			return defending * 0.6 \
				+ physical * 0.25 \
				+ passing * 0.15

		Position.LB, Position.RB:
			return defending * 0.45 \
				+ pace * 0.25 \
				+ passing * 0.20 \
				+ physical * 0.10

		Position.CDM:
			return defending * 0.40 \
				+ passing * 0.35 \
				+ physical * 0.25

		Position.CM:
			return passing * 0.45 \
				+ dribbling * 0.20 \
				+ defending * 0.20 \
				+ physical * 0.15

		Position.CAM:
			return passing * 0.40 \
				+ dribbling * 0.30 \
				+ shooting * 0.20 \
				+ pace * 0.10

		Position.LW, Position.RW:
			return pace * 0.30 \
				+ dribbling * 0.30 \
				+ shooting * 0.25 \
				+ passing * 0.15

		Position.ST:
			return shooting * 0.45 \
				+ pace * 0.25 \
				+ physical * 0.20 \
				+ dribbling * 0.10

		_:
			push_error("Posición no soportada en PlayerData.get_rating_for_position()")
			return 50.0

static func position_to_string(position: Position) -> String:
	match position:
		Position.GK: return "GK"
		Position.LB: return "LB"
		Position.CB: return "CB"
		Position.RB: return "RB"
		Position.CDM: return "CDM"
		Position.CM: return "CM"
		Position.CAM: return "CAM"
		Position.LW: return "LW"
		Position.RW: return "RW"
		Position.ST: return "ST"

	return "Unknown"