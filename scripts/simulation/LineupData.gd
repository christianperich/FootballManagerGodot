class_name LineupData
extends Resource

var slots: Array[LineupSlot] = []


func get_players() -> Array[PlayerData]:
	var players: Array[PlayerData] = []

	for slot: LineupSlot in slots:
		players.append(slot.player)

	return players


func get_goalkeeper() -> PlayerData:
	for slot: LineupSlot in slots:
		if slot.formation_slot.position == PlayerData.Position.GK:
			return slot.player

	return null


func get_players_by_positions(
	positions: Array[PlayerData.Position]
) -> Array[PlayerData]:
	var result: Array[PlayerData] = []

	for slot in slots:
		if slot.formation_slot.position in positions:
			result.append(slot.player)

	return result

func get_slots_by_positions(
	positions: Array[PlayerData.Position]
) -> Array[LineupSlot]:
	var result: Array[LineupSlot] = []

	for slot: LineupSlot in slots:
		if slot.formation_slot.position in positions:
			result.append(slot)

	return result
