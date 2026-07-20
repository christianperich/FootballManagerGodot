class_name TeamRatingCalculator
extends RefCounted

func calculate(team: LineupData) -> TeamRatings:
	"""if team.players.size() == 0:
			return calculate_from_team(team)"""

	var ratings := TeamRatings.new()

	var players = team.starters
	ratings.attack = calculate_attack(players)
	ratings.midfield = calculate_midfield(players)
	ratings.defense = calculate_defense(players)

	ratings.overall = (
		ratings.attack +
		ratings.midfield +
		ratings.defense
	) / 3.0

	return ratings

func calculate_attack(players: Array[PlayerData]) -> float:
	var total := 0.0
	var count := 0

	for player in players:
		if player.primary_position == PlayerData.Position.ST or player.primary_position == PlayerData.Position.LW or player.primary_position == PlayerData.Position.RW:
			total += player.get_rating_for_position(player.primary_position)
			count += 1

	if count == 0:
		return 0

	return total / count

func calculate_midfield(players: Array[PlayerData]) -> float:
	var total := 0.0
	var count := 0

	for player in players:
		match player.primary_position:
			PlayerData.Position.CDM, \
			PlayerData.Position.CM, \
			PlayerData.Position.CAM:
				total += player.get_rating_for_position(player.primary_position)
				count += 1

	if count == 0:
		return 0

	return total / count

func calculate_defense(players: Array[PlayerData]) -> float:
	var total := 0.0
	var count := 0

	for player in players:
		match player.primary_position:
			PlayerData.Position.GK, \
			PlayerData.Position.CB, \
			PlayerData.Position.LB, \
			PlayerData.Position.RB:
				total += player.get_rating_for_position(player.primary_position)
				count += 1

	if count == 0:
		return 0

	return total / count

func calculate_from_team(team: TeamData) -> TeamRatings:
	var ratings := TeamRatings.new()

	ratings.attack = team.attack
	ratings.midfield = team.midfield
	ratings.defense = team.defense

	ratings.overall = (
		ratings.attack +
		ratings.midfield +
		ratings.defense
	) / 3.0

	return ratings
