class_name NationalityData
extends Resource

@export_category("Información")

@export var name: String

@export var fifa_code: String

@export var iso_code: String

@export var language: String

@export var continent: Continent

@export var confederation: Confederation

@export var reputation: int

@export var youth_quality: int

@export var economic_power: int

@export var flag: Texture2D


enum Continent {
	SOUTH_AMERICA,
	NORTH_AMERICA,
	EUROPE,
	AFRICA,
	ASIA,
	OCEANIA
}

enum Confederation {
	CONMEBOL,
	CONCACAF,
	UEFA,
	CAF,
	AFC,
	OFC
}