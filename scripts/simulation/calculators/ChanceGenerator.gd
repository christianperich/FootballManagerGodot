class_name ChanceGenerator
extends RefCounted

func generate(attacking_team: TeamData, defending_team: TeamData, minute: int) -> ChanceEvent:

	var offense = (
	attacking_team.attack * 0.5 +
	attacking_team.midfield * 0.5
	)

	var defense = (
		defending_team.defense * 0.7 +
		defending_team.midfield * 0.3
	)

	var probability = float(offense) / float(offense + defense)
	probability *= 0.9

	if randf() > probability:
		return null

	var chance = ChanceEvent.new()

	chance.minute = minute
	chance.attacking_team = attacking_team
	chance.defending_team = defending_team

	return chance
