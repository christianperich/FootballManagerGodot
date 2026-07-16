extends Resource
class_name TeamData

@export_category("Información Básica")
@export var name: String = ""
@export_file("*.png") var shield_icon: String # Ruta para el escudo/logo


@export_category("Factores de Simulación")
## Fuerza general (puedes usarlo como un promedio o dejarlo como valor base)
@export_range(1, 100) var strength: int = 50

## Poder ofensivo del equipo (probabilidad y efectividad de tiros a puerta)
@export_range(1, 100) var attack: int = 50

## Control de juego (ayuda a determinar la posesión y generación de jugadas)
@export_range(1, 100) var midfield: int = 50

## Solidez defensiva (capacidad de bloquear ataques y efectividad del portero)
@export_range(1, 100) var defense: int = 50

## Consistencia (un equipo con baja consistencia jugará de forma muy aleatoria, uno alto será muy regular)
@export_range(1, 100) var consistency: int = 70

## Factor de Localía (bonificación de rendimiento que recibe al jugar en su estadio)
@export_range(1.0, 1.2) var home_advantage_multiplier: float = 1.05
