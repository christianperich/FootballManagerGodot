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
		probability *= 0.6

		if randf() > probability:
			return null

	#=========================================
	# Obtener alineación atacante
	#=========================================

	var lineup : LineupData = context.get_lineup(attacking_team)

	#=========================================
	# Seleccionar protagonistas
	#=========================================
	var defenders_positions = ["LB","SW","CB","RB"]
	var midfielders_positions = ["CDM","CM","CAM","LM","RM"]
	var attackers_positions = ["LW","RW","FW","ST"]
	
	var defenders: Array[PlayerData]
	var midfielders: Array[PlayerData]
	var attackers: Array[PlayerData]
	
	for player in lineup.starters:
		var position = player.position_to_string(player.primary_position)
		if defenders_positions.has(position):
			defenders.append(player)
		elif midfielders_positions.has(position):
			midfielders.append(player)
		elif attackers_positions.has(position):
			attackers.append(player)
		else:
			continue
			
	
	var creator := player_selector.pick_creator(defenders, midfielders, attackers)
	var finisher := player_selector.pick_finisher(defenders, midfielders, attackers)

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
