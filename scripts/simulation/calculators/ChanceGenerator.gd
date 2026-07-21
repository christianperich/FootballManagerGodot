class_name ChanceGenerator
extends RefCounted

var player_selector := PlayerSelector.new()

func generate(
	context: MatchContext,
	attacking_team: TeamData,
	defending_team: TeamData
	) -> ChanceEvent:
	#=========================================
	# Calcular probabilidad de generar ocasión
	#=========================================
	var offense: float
	var defense: float

	if attacking_team == context.home_team:
		offense = (
			context.home_ratings.attack * 0.5 +
			context.home_ratings.midfield * 0.5
		)

		defense = (
			context.away_ratings.defense * 0.7 +
			context.away_ratings.midfield * 0.3
		)

	else:
		offense = (
			context.away_ratings.attack * 0.5 +
			context.away_ratings.midfield * 0.5
		)

		defense = (
			context.home_ratings.defense * 0.7 +
			context.home_ratings.midfield * 0.3
		)

	var probability := offense / (offense + defense)
	probability *= 0.75

	if randf() > probability:
		return null

	#=========================================
	# Obtener alineación atacante
	#=========================================

	var lineup: LineupData = context.get_lineup(attacking_team)
	"""#imprimir los jgadores de la alineación
	print("Alineación de %s:" % attacking_team.name)
	for player in lineup.get_players():
		print("%s %s (%s)" % [
			player.first_name,
			player.last_name,
			PlayerData.position_to_string(player.primary_position)
		])"""
	
	
	#=========================================
	# Seleccionar protagonistas
	#=========================================
	
	var creator = player_selector.pick_creator(lineup)

	var finisher = player_selector.pick_finisher(
		lineup,
		creator
	)

	#=========================================
	# Crear evento
	#=========================================

	var chance := ChanceEvent.new()

	chance.minute = context.minute

	chance.attacking_team = attacking_team
	chance.defending_team = defending_team

	chance.creator = creator
	chance.finisher = finisher
	

	return chance
