class_name MatchSimulator
extends RefCounted

var possession_calculator := PossessionCalculator.new()
var chance_generator := ChanceGenerator.new()
var shot_resolver := ShotResolver.new()
var shot_quality_calculator := ShotQualityCalculator.new()
var goal_resolver := GoalResolver.new()

func simulate(home_team: TeamData, away_team: TeamData) -> MatchContext:

	var context := MatchContext.new()
	context.initialize(home_team, away_team)

	for minute in range(1, 91):

		context.minute = minute

		simulate_minute(context)

	return context

func simulate_minute(context: MatchContext):

	var attacking = possession_calculator.pick_attacking_team(context)

	var defending: TeamData

	if attacking == context.home_team:
		defending = context.away_team
		context.home_attacks += 1
	else:
		defending = context.home_team
		context.away_attacks += 1

	var chance = chance_generator.generate(
		attacking,
		defending,
		context.minute
	)

	if chance == null:
		return

	context.events.append(chance)

	if attacking == context.home_team:
		context.home_chances += 1
	else:
		context.away_chances += 1
	
	

	var shot = shot_resolver.resolve(chance)

	if shot == null:
		return


	# Calculamos calidad
	shot_quality_calculator.calculate(shot)


	context.events.append(shot)


	if attacking == context.home_team:
		context.home_shots += 1
	else:
		context.away_shots += 1


	# Resolver gol

	var goal = goal_resolver.resolve(shot)


	if goal:

		var goal_event = GoalEvent.new()

		goal_event.minute = context.minute
		goal_event.attacking_team = attacking
		goal_event.defending_team = defending
		goal_event.shot = shot


		context.events.append(goal_event)	


		if attacking == context.home_team:
			context.home_goals += 1
			"""var player : PlayerData = context.home_team.players.pick_random()
			print("%s' Gol de %s %s para %s" % [str(context.minute), player.first_name,player.last_name, context.home_team.name])"""
		
		else:
			context.away_goals += 1
			"""var player : PlayerData = context.away_team.players.pick_random()
			print("%s' Gol de %s %s para %s" % [str(context.minute), player.first_name,player.last_name, context.away_team.name])"""
		
