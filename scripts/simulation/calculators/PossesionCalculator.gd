class_name PossessionCalculator
extends RefCounted


func pick_attacking_team(context: MatchContext) -> TeamData:

	var home_power = calculate_power(
		context.home_team,
		true
	)

	var away_power = calculate_power(
		context.away_team,
		false
	)


	var total = home_power + away_power

	var home_probability = home_power / total


	if randf() < home_probability:
		return context.home_team
	else:
		return context.away_team



func calculate_power(team: TeamData, is_home: bool) -> float:

	var power = (
		team.midfield * 0.60 +
		team.attack * 0.25 +
		team.defense * 0.15
	)


	"""if is_home:
		power *= team.home_advantage_multiplier"""


	return power
