class_name LineupGenerator
extends RefCounted


func generate(team: TeamData) -> LineupData:

	var lineup := LineupData.new()

	for position in team.default_formation.positions:

		var player := _best_player(
			team.players,
			position,
			lineup.starters
		)

		if player:
			lineup.starters.append(player)

	return lineup


func _best_player(
	players: Array[PlayerData],
	position: PlayerData.Position,
	used_players: Array[PlayerData]
) -> PlayerData:

	var best_player: PlayerData
	var best_rating := -1.0

	for player in players:

		if used_players.has(player):
			continue

		var rating = player.get_rating_for_position(position)

		if rating <= 0:
			continue

		if rating > best_rating:
			best_rating = rating
			best_player = player

	return best_player
