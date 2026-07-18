class_name PlayersGenerator
extends RefCounted

"""const AUDAX = preload("uid://c6k8f07rpsu4v")

func _ready() -> void:
	generate_squad(AUDAX)"""

func generate_squad(team: TeamData):
	var strenght = (team.attack + team.midfield + team.defense) / 3
	for i in range(2):
		generate_player(PlayerData.Position.GK, strenght, team)
		generate_player(PlayerData.Position.LB, strenght, team)
		generate_player(PlayerData.Position.CB, strenght, team)
		generate_player(PlayerData.Position.CB, strenght, team)
		generate_player(PlayerData.Position.RB, strenght, team)
		generate_player(PlayerData.Position.CDM, strenght, team)
		generate_player(PlayerData.Position.CM, strenght, team)
		generate_player(PlayerData.Position.CAM, strenght, team)
		generate_player(PlayerData.Position.LW, strenght, team)
		generate_player(PlayerData.Position.RW, strenght, team)
		generate_player(PlayerData.Position.ST, strenght, team)
		
func generate_player(position: PlayerData.Position, strenght: int, team:TeamData):
	var player := PlayerData.new()
	player.first_name = get_fisrt_name()
	player.last_name = get_last_name()
	player.primary_position = position
	player.age = randi_range(17, 35)
	player.pace = strenght + randi_range(-10, 10)
	player.shooting = strenght + randi_range(-10, 10)
	player.passing = strenght + randi_range(-10, 10)
	player.dribbling = strenght + randi_range(-10, 10)
	player.defending = strenght + randi_range(-10, 10)
	player.physical = strenght + randi_range(-10, 10)
	player.goalkeeping = strenght + randi_range(-10, 10)

	#print_player(player)

	team.players.append(player)
	

func print_player(player : PlayerData):
	print("------------------")
	print("Name: %s %s" % [player.first_name, player.last_name])
	print("Age: %d" % player.age)
	print("Position: %s" % PlayerData.position_to_string(player.primary_position))
	print("Pace: %d" % player.pace)
	print("Shooting: %d" % player.shooting)
	print("Passing: %d" % player.passing)
	print("Dribbling: %d" % player.dribbling)
	print("Defending: %d" % player.defending)
	print("Physical: %d" % player.physical)
	print("Goalkeeping: %d" % player.goalkeeping)

func get_fisrt_name() -> String:
	var first_names = [
		"Juan",
		"Pedro",
		"Luis",
		"Carlos",
		"Jorge",
		"Miguel",
		"Andrés",
		"Diego",
		"Fernando",
		"Ricardo",
		"Sergio",
		"Francisco",
		"Roberto",
		"Javier",
		"Alberto",
		"Raúl",
		"Héctor",
		"Manuel",
		"Eduardo",
		"Gustavo",
		"Joaquín",
		"Rafael",
		"Antonio",
		"Víctor",
		"Emilio",
		"Pablo",
		"Martín",
		"Enrique",
		"Ricardo",
		"Santiago",
		"Roberto",
		"Ricardo",
		"Santiago",
		"Agustín",
		"Alonso",
		]
	return first_names[randi() % first_names.size()]

func get_last_name() -> String:
	var last_names = [
		"González",
		"Pérez",
		"López",
		"Rodríguez",
		"Gutiérrez",
		"Martínez",
		"Hernández",
		"Ramírez",
		"Torres",
		"Flores",
		"Rivera",
		"Vargas",
		"Castillo",
		"Rojas",
		"Mendoza",
		"Silva",
		"Morales",
		"Cruz",
		"Ortiz",
		"Gómez",
		"Díaz",
		"Sánchez",
		"Reyes",
		"Castro",
		"Vega",
		"Ramos",
		"Guerrero",
		"Paredes",
		"Salazar",
		"Campos",
		"Fuentes",
		"Cabrera",
		"Valenzuela",
		"Cortés",
		"Bravo",
		"Navarro",
		"Molina",
		"Riquelme",
		"Acuña",
		"Alarcón",
		]
	return last_names[randi() % last_names.size()]
