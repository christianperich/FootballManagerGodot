class_name MatchContext
extends RefCounted

var home_team: TeamData
var away_team: TeamData

var home_lineup: LineupData
var away_lineup: LineupData

var home_ratings: TeamRatings
var away_ratings: TeamRatings

var minute: int = 0

var home_attacks: int = 0
var away_attacks: int = 0

var home_chances: int = 0
var away_chances: int = 0

var home_shots: int = 0
var away_shots: int = 0

var home_shots_on_target: int = 0
var away_shots_on_target: int = 0

var home_goals: int = 0
var away_goals: int = 0

var events: Array[MatchEvent] = []

func initialize(home: TeamData, away: TeamData) -> void:
	home_team = home
	away_team = away
	
	#Alineaciones de los equipos
	var lineup_generator := LineupGenerator.new()

	home_lineup = lineup_generator.generate(home)
	away_lineup = lineup_generator.generate(away)

	#Calcula el Rating de los equipos
	var calculator := TeamRatingCalculator.new()

	home_ratings = calculator.calculate(home_lineup)
	away_ratings = calculator.calculate(away_lineup)

func add_attack(attacking: TeamData):
	if attacking == home_team:
		home_attacks += 1
	else:
		away_attacks += 1
		
func add_chance(attacking: TeamData):
	if attacking == home_team:
		home_chances += 1
	else:
		away_chances += 1
		
func add_shot(attacking: TeamData):
	if attacking == home_team:
		home_shots += 1
	else:
		away_shots += 1
		
func add_goal(attacking: TeamData):
	if attacking == home_team:
		home_goals += 1
	else:
		away_goals += 1
	
func get_lineup(team : TeamData):
	if team == home_team:
		return home_lineup
	else:
		return away_lineup

func add_event(event: MatchEvent) -> void:
	events.append(event)
