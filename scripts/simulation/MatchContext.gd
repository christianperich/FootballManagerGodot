class_name MatchContext
extends RefCounted

#=========================================
# Equipos
#=========================================

var home_team: TeamData
var away_team: TeamData

var home_ratings: TeamRatings
var away_ratings: TeamRatings

#=========================================
# Tiempo
#=========================================

var minute: int = 0

#=========================================
# Estadísticas
#=========================================

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

#=========================================
# Eventos
#=========================================

var events: Array[MatchEvent] = []

#=========================================
# Inicialización
#=========================================

func initialize(home: TeamData, away: TeamData) -> void:
	home_team = home
	away_team = away

	var calculator := TeamRatingCalculator.new()

	home_ratings = calculator.calculate(home)
	away_ratings = calculator.calculate(away)

#=========================================
# Eventos
#=========================================

func add_event(event: MatchEvent) -> void:
	events.append(event)

#=========================================
# Utilidades
#=========================================

func add_goal(team: TeamData) -> void:
	if team == home_team:
		home_goals += 1
	else:
		away_goals += 1


func add_shot(team: TeamData) -> void:
	if team == home_team:
		home_shots += 1
	else:
		away_shots += 1


func add_shot_on_target(team: TeamData) -> void:
	if team == home_team:
		home_shots_on_target += 1
	else:
		away_shots_on_target += 1


func add_chance(team: TeamData) -> void:
	if team == home_team:
		home_chances += 1
	else:
		away_chances += 1


func add_attack(team: TeamData) -> void:
	if team == home_team:
		home_attacks += 1
	else:
		away_attacks += 1