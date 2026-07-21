class_name ShotResolver
extends RefCounted

func resolve(chance: ChanceEvent) -> ShotEvent:
	var attack = chance.attacking_team.attack
	var defense = chance.defending_team.defense

	var probability = float(attack) / float(attack + defense)

	probability *= 0.45

	if randf() > probability:
		return null

	var shot = ShotEvent.new()

	shot.minute = chance.minute
	shot.attacking_team = chance.attacking_team
	shot.defending_team = chance.defending_team
	
	shot.shooter = chance.finisher
	shot.assist = chance.creator

	chance.shot = shot

	return shot
