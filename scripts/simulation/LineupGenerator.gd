class_name LineupGenerator
extends RefCounted


func generate(team: TeamData) -> LineupData:

	var lineup := LineupData.new()
	for position in team.default_formation.positions:

		var player = _best_player(
			team,
			position,
			lineup.starters
		)

		if player:
			lineup.starters.append(player)

	return lineup
	
func _best_player(
	team:TeamData, 
	position:PlayerData.Position, 
	lineup:Array[PlayerData]
	) -> PlayerData:

	var best: PlayerData
	var best_rating := -1.0
	
	var selectable_players:Array[PlayerData]
	
	
	for player:PlayerData in team.players:
		if player.primary_position == position:
			selectable_players.append(player)
			#print("Agregado %s %s en la posición %s" % [player.first_name, player.last_name, position])
			return
	
	#Solo está seleccionando el primero. Tiene que ser por rating

	return #best

func _best_players(
	players: Array[PlayerData],
	positions: Array,
	used: Array[PlayerData]
	) -> Array[PlayerData]:

	var result: Array[PlayerData] = []

	for position in positions:

		var best: PlayerData
		var best_rating := -1.0

		for player in players:

			if used.has(player):
				continue

			if result.has(player):
				continue

			if player.primary_position != position:
				continue

			var rating = player.get_rating_for_position(position)

			if rating > best_rating:
				best_rating = rating
				best = player

		if best:
			result.append(best)

	return result
