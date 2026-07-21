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

func simulate_minute(context: MatchContext) -> void:

	var attacking = possession_calculator.pick_attacking_team(context)
	var defending = _get_defending_team(context, attacking)

	_register_attack(context, attacking)

	var chance = simulate_chance(
		context,
		attacking,
		defending
	)

	if chance == null:
		return

	var shot = simulate_shot(
		context,
		chance
	)

	if shot == null:
		return

	simulate_goal(
		context,
		shot
	)

func simulate_chance(
	context: MatchContext,
	attacking: TeamData,
	defending: TeamData
	) -> ChanceEvent:

	var chance = chance_generator.generate(
		context,
		attacking,
		defending
	)

	if chance == null:
		return null

	context.add_event(chance)
	context.add_chance(attacking)
	

	return chance

func simulate_shot(
	context: MatchContext,
	chance: ChanceEvent
	) -> ShotEvent:

	var shot = shot_resolver.resolve(chance)

	if shot == null:
		return null

	shot_quality_calculator.calculate(shot)
	
	
	context.add_event(shot)
	context.add_shot(chance.attacking_team)

	return shot

func simulate_goal(
	context: MatchContext,
	shot: ShotEvent
	) -> void:

	if !goal_resolver.resolve(shot):
		return

	var goal := GoalEvent.new()

	goal.minute = context.minute
	goal.attacking_team = shot.attacking_team
	goal.defending_team = shot.defending_team
	goal.shot = shot

	goal.scorer = shot.shooter
	goal.assist = shot.assist
	goal.goalkeeper = shot.goalkeeper

	context.add_event(goal)
	context.add_goal(shot.attacking_team)

func _register_attack(
	context: MatchContext,
	attacking: TeamData
	) -> void:

	context.add_attack(attacking)

func _get_defending_team(
	context: MatchContext,
	attacking: TeamData
	) -> TeamData:

	if attacking == context.home_team:
		return context.away_team

	return context.home_team
