class_name GoalResolver
extends RefCounted


func resolve(shot: ShotEvent) -> bool:

	var chance = shot.xg

	if randf() < chance:

		shot.result = ShotEvent.ShotResult.GOAL
		return true


	# Si no es gol, determinamos qué pasó

	var random_result = randf()

	if random_result < 0.65:
		shot.result = ShotEvent.ShotResult.SAVED

	elif random_result < 0.80:
		shot.result = ShotEvent.ShotResult.OFF_TARGET

	else:
		shot.result = ShotEvent.ShotResult.WOODWORK


	return false
