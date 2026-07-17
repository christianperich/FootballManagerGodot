class_name CompetitionData
extends Resource

@export var name: String
@export var country: NationalityData

@export var divisions: int

@export var teams: Array[TeamData]
var matchdays: Array[MatchdayData]

@export var promotion_places: int
@export var relegation_places: int