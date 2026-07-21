class_name TeamRatingCalculator
extends RefCounted


func calculate(lineup: LineupData) -> TeamRatings:
	var ratings := TeamRatings.new()

	ratings.attack = calculate_attack(lineup)
	ratings.midfield = calculate_midfield(lineup)
	ratings.defense = calculate_defense(lineup)

	ratings.overall = (
		ratings.attack +
		ratings.midfield +
		ratings.defense
	) / 3.0

	return ratings


func calculate_attack(lineup: LineupData) -> float:
	var slots = lineup.get_slots_by_positions([
		PlayerData.Position.LW,
		PlayerData.Position.RW,
		PlayerData.Position.FW,
		PlayerData.Position.ST
	])

	return _average_rating(slots)


func calculate_midfield(lineup: LineupData) -> float:
	var slots = lineup.get_slots_by_positions([
		PlayerData.Position.CDM,
		PlayerData.Position.CM,
		PlayerData.Position.CAM,
		PlayerData.Position.LM,
		PlayerData.Position.RM
	])

	return _average_rating(slots)


func calculate_defense(lineup: LineupData) -> float:
	var slots = lineup.get_slots_by_positions([
		PlayerData.Position.GK,
		PlayerData.Position.LB,
		PlayerData.Position.SW,
		PlayerData.Position.CB,
		PlayerData.Position.RB
	])

	return _average_rating(slots)


func _average_rating(slots: Array[LineupSlot]) -> float:
	if slots.is_empty():
		return 0

	var total := 0.0

	for slot: LineupSlot in slots:
		total += slot.player.get_rating_for_position(
			slot.formation_slot.position
		)

	return total / slots.size()
