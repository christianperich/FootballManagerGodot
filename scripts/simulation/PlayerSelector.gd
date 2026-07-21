class_name PlayerSelector
extends RefCounted

var creator : PlayerData
var finisher : PlayerData

func pick_creator(defenders, midfielders, attackers) -> PlayerData:
	var prob:float = randf_range(0,1)
	
	if prob < 0.1:
		creator = defenders.pick_random()
	elif prob < 0.7:
		creator = midfielders.pick_random()
	else:
		creator = attackers.pick_random()
	
	return creator

func pick_finisher(defenders, midfielders, attackers) -> PlayerData:
	var prob:float = randf_range(0,1)
	if prob < 0.1:
		finisher = defenders.pick_random()
	elif prob < 0.7:
		finisher = midfielders.pick_random()
	else:
		finisher = attackers.pick_random()
		
	if finisher == creator:
		pick_finisher(defenders,midfielders,attackers)
		
	return finisher
