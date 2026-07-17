class_name ShotEvent
extends MatchEvent


enum ShotResult {
	OFF_TARGET,  # Fuera del arco
	SAVED,       # Atajado por el arquero
	WOODWORK,    # Palo o travesaño
	GOAL         # Gol
}


# Calidad del remate (Expected Goals)
# Ejemplo:
# 0.05 = remate muy difícil
# 0.50 = ocasión clara
# 0.75 = mano a mano
var xg: float = 0.0


# Resultado final del disparo
var result: ShotResult = ShotResult.OFF_TARGET


# Datos adicionales del remate

# ¿Fue al arco?
var on_target: bool = false


# Tipo de remate (por ahora básico)
enum ShotType {
	OPEN_PLAY,    # Jugada normal
	HEADER,       # Cabeceo
	LONG_SHOT,    # Remate lejano
	ONE_ON_ONE,   # Mano a mano
	SET_PIECE     # Balón detenido
}

var shot_type: ShotType = ShotType.OPEN_PLAY


func _init():
	type = EventType.SHOT
