class_name PlayersGenerator
extends Node

const team_data = preload("res://resources/teams/chile/audax.tres")

func _ready():
	generate_squad(TeamData.new())

func generate_squad(team: TeamData):
	var strenght = (team.attack + team.midfield + team.defense) / 3
	for i in range(2):
		generate_player(PlayerData.Position.GK, strenght)
		generate_player(PlayerData.Position.LB, strenght)
		generate_player(PlayerData.Position.CB, strenght)
		generate_player(PlayerData.Position.RB, strenght)
		generate_player(PlayerData.Position.CDM, strenght)
		generate_player(PlayerData.Position.CM, strenght)
		generate_player(PlayerData.Position.CAM, strenght)
		generate_player(PlayerData.Position.LW, strenght)
		generate_player(PlayerData.Position.RW, strenght)
		generate_player(PlayerData.Position.ST, strenght)
		

func generate_player(position: PlayerData.Position, strenght: int):
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

	team_data.players.append(player)

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
