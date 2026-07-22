class_name LineupGenerator
extends RefCounted


func generate(team: TeamData) -> LineupData:
	var lineup : LineupData = LineupData.new()

	var used_players: Array[PlayerData] = []

	for slot: FormationSlot in team.formation.slots:
		var player := _best_player(
			team.players,
			slot.position,
			used_players
		)

		if player == null:
			push_warning(
				"No se encontró jugador para %s en %s" % [
					PlayerData.position_to_string(slot.position),
					team.name
				]
			)
			continue

		used_players.append(player)

		var lineup_slot := LineupSlot.new()

		lineup_slot.player = player
		lineup_slot.formation_slot = slot

		lineup.slots.append(lineup_slot)

		"""print("%s %s - %s - %s (Natural)" % [
			player.first_name, 
			player.last_name, 
			PlayerData.position_to_string(lineup_slot.formation_slot.position),
			PlayerData.position_to_string(player.primary_position)
			])"""

	return lineup


func _best_player(
	players: Array[PlayerData],
	position: PlayerData.Position,
	used: Array[PlayerData]
) -> PlayerData:
	var best: PlayerData
	var best_rating := -1.0

	for player in players:
		if used.has(player):
			continue

		var rating = player.get_rating_for_position(position)

		if rating > best_rating:
			best_rating = rating
			best = player

	return best
