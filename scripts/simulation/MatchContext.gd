class_name MatchContext
extends RefCounted

var home_team: TeamData
var away_team: TeamData

var minute := 0

var home_attacks := 0
var away_attacks := 0

var home_chances := 0
var away_chances := 0

var home_shots := 0
var away_shots := 0

var home_goals := 0
var away_goals := 0

var events: Array[MatchEvent] = []

func initialize(home: TeamData, away: TeamData) -> void:
	home_team = home
	away_team = away

func add_event(event: MatchEvent) -> void:
	events.append(event)
