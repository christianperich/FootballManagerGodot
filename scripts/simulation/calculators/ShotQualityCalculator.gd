class_name ShotQualityCalculator
extends RefCounted


func calculate(shot: ShotEvent) -> float:
	var attacker = shot.attacking_team
	var defender = shot.defending_team
	

	var finisher = shot.shooter

	var finishing_power = (
		finisher.shooting * 0.6 +
		finisher.get_rating_for_position(
			finisher.primary_position
		) * 0.4
	)

	var offensive_power = (
		attacker.attack * 0.6 +
		attacker.midfield * 0.4
	)

	var defensive_power = defender.defense

	var base = float(offensive_power) / float(offensive_power + defensive_power)


	# Reducimos la calidad base
	var quality = (
		base * 0.30 +
		finishing_power / 100.0 * 0.20
	)


	# Variación natural
	quality *= randf_range(0.5, 1.5)


	shot.xg = clamp(
		quality,
		0.02,
		0.40
	)


	return shot.xg
