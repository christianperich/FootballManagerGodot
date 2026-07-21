class_name ShotQualityCalculator
extends RefCounted


func calculate(shot: ShotEvent) -> float:

	var attacker = shot.attacking_team
	var defender = shot.defending_team
	
	var assist = shot.assist
	var finisher = shot.shooter

	var offensive_power = (
		attacker.attack * 0.6 +
		attacker.midfield * 0.4
	)

	var defensive_power = defender.defense

	var base = float(offensive_power) / float(offensive_power + defensive_power)


	# Reducimos la calidad base
	var quality = base * 0.35


	# Variación natural
	quality *= randf_range(0.5,1.5)


	shot.xg = clamp(
		quality,
		0.02,
		0.55
	)


	return shot.xg
