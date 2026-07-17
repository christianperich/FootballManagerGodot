class_name TeamRatingCalculator
extends RefCounted

func calculate(team: TeamData) -> TeamRatings:
	var ratings := TeamRatings.new()

	ratings.attack = calculate_attack(team)
	ratings.midfield = calculate_midfield(team)
	ratings.defense = calculate_defense(team)

	ratings.overall = (
		ratings.attack +
		ratings.midfield +
		ratings.defense
	) / 3.0

	return ratings

func calculate_attack(team: TeamData) -> float:
	var total := 0.0
	var count := 0

	for player in team.players:
		if player.position == PlayerData.Position.ST \
		or player.position == PlayerData.Position.LW \
		or player.position == PlayerData.Position.RW:
			total += player.get_rating_for_position(player.position)
			count += 1

	if count == 0:
		return 0

	return total / count

func calculate_midfield(team: TeamData) -> float:
	var total := 0.0
	var count := 0

	for player in team.players:
		match player.position:
			PlayerData.Position.CDM, \
			PlayerData.Position.CM, \
			PlayerData.Position.CAM:
				total += player.get_rating_for_position(player.position)
				count += 1

	if count == 0:
		return 0

	return total / count

func calculate_defense(team: TeamData) -> float:
	var total := 0.0
	var count := 0

	for player in team.players:
		match player.position:
			PlayerData.Position.GK, \
			PlayerData.Position.CB, \
			PlayerData.Position.LB, \
			PlayerData.Position.RB:
				total += player.get_rating_for_position(player.position)
				count += 1

	if count == 0:
		return 0

	return total / count