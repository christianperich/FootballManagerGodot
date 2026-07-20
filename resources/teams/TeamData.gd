class_name TeamData
extends Resource

const def_formation = preload("uid://dxfsup2lutncx")

@export_category("Información Básica")
@export var name: String
@export var short_name: String
@export var abreviation: String

@export_category("Estadísticas")
@export_range(0, 100) var attack: float = 50
@export_range(0, 100) var midfield: float = 50
@export_range(0, 100) var defense: float = 50

@export_category("Plantilla")
@export var default_formation: FormationData = def_formation
@export var players: Array[PlayerData]
