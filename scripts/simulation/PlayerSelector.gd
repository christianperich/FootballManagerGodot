class_name PlayerSelector
extends RefCounted

func pick_creator(lineup: LineupData) -> PlayerData:
	return _pick_weighted_player(
		lineup.get_players(),
		_creator_weight
	)


func pick_finisher(
	lineup: LineupData,
	creator: PlayerData = null
) -> PlayerData:
	var candidates: Array[PlayerData] = []

	for player in lineup.get_players():
		if player != creator:
			candidates.append(player)

	return _pick_weighted_player(
		candidates,
		_finisher_weight
	)


#==================================================
# SELECCION PONDERADA
#==================================================

func _pick_weighted_player(
	players: Array[PlayerData],
	weight_function: Callable
	) -> PlayerData:
	var total_weight := 0.0

	var weights: Array[float] = []

	for player in players:
		var weight: float = weight_function.call(player)

		weights.append(weight)

		total_weight += weight


	if total_weight <= 0:
		return players.pick_random()


	var random := randf() * total_weight

	var accumulated := 0.0

	for i in range(players.size()):
		accumulated += weights[i]

		if random <= accumulated:
			return players[i]

	return players.back()


#==================================================
# PESOS
#==================================================

func _creator_weight(player: PlayerData) -> float:
	var base := 1.0

	match player.primary_position:
		PlayerData.Position.GK:
			base = 0

		PlayerData.Position.CB:
			base = 3

		PlayerData.Position.SW:
			base = 4

		PlayerData.Position.LB, \
		PlayerData.Position.RB:
			base = 10

		PlayerData.Position.CDM:
			base = 18

		PlayerData.Position.CM:
			base = 28

		PlayerData.Position.CAM:
			base = 40

		PlayerData.Position.LM, \
		PlayerData.Position.RM:
			base = 35

		PlayerData.Position.LW, \
		PlayerData.Position.RW:
			base = 32

		PlayerData.Position.FW:
			base = 22

		PlayerData.Position.ST:
			base = 18

	return base * (player.get_rating_for_position(player.primary_position) / 100.0)


func _finisher_weight(player: PlayerData) -> float:
	var base := 1.0

	match player.primary_position:
		PlayerData.Position.GK:
			base = 0

		PlayerData.Position.CB:
			base = 2

		PlayerData.Position.SW:
			base = 2

		PlayerData.Position.LB, \
		PlayerData.Position.RB:
			base = 4

		PlayerData.Position.CDM:
			base = 5

		PlayerData.Position.CM:
			base = 12

		PlayerData.Position.CAM:
			base = 20

		PlayerData.Position.LM, \
		PlayerData.Position.RM:
			base = 18

		PlayerData.Position.LW, \
		PlayerData.Position.RW:
			base = 25

		PlayerData.Position.FW:
			base = 50

		PlayerData.Position.ST:
			base = 60

	return base * (player.get_rating_for_position(player.primary_position) / 100.0)
