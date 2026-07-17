class_name TeamData
extends Resource

@export_category("Información Básica")
@export var name: String
@export var short_name: String

@export_category("Estadísticas")
@export_range(0, 100) var attack: float = 50
@export_range(0, 100) var midfield: float = 50
@export_range(0, 100) var defense: float = 50

@export_category("Plantilla")
@export var players: Array[PlayerData]
