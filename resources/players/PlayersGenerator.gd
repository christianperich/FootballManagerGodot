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
	generate_attributes(player, strenght)

	#rint_player(player)

	team.players.append(player)
	
func generate_attributes(player:PlayerData, strength:int):

	match player.primary_position:

		PlayerData.Position.GK:

			player.goalkeeping = random_attribute(strength + 8)
			player.passing      = random_attribute(strength - 5)
			player.physical     = random_attribute(strength - 5)
			player.pace         = random_attribute(30)
			player.dribbling    = random_attribute(25)
			player.shooting     = random_attribute(15)
			player.defending    = random_attribute(20)


		PlayerData.Position.CB:

			player.defending    = random_attribute(strength + 8)
			player.physical     = random_attribute(strength + 5)
			player.passing      = random_attribute(strength - 5)
			player.pace         = random_attribute(strength - 5)
			player.dribbling    = random_attribute(strength - 15)
			player.shooting     = random_attribute(25)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.LB, PlayerData.Position.RB:

			player.defending    = random_attribute(strength + 5)
			player.pace         = random_attribute(strength + 5)
			player.passing      = random_attribute(strength)
			player.dribbling    = random_attribute(strength - 5)
			player.physical     = random_attribute(strength)
			player.shooting     = random_attribute(strength - 20)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.CDM:

			player.defending    = random_attribute(strength + 5)
			player.passing      = random_attribute(strength + 5)
			player.physical     = random_attribute(strength)
			player.dribbling    = random_attribute(strength - 5)
			player.pace         = random_attribute(strength - 5)
			player.shooting     = random_attribute(strength - 15)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.CM:

			player.passing      = random_attribute(strength + 5)
			player.dribbling    = random_attribute(strength)
			player.physical     = random_attribute(strength)
			player.pace         = random_attribute(strength)
			player.defending    = random_attribute(strength - 5)
			player.shooting     = random_attribute(strength - 5)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.CAM:

			player.passing      = random_attribute(strength + 8)
			player.dribbling    = random_attribute(strength + 5)
			player.shooting     = random_attribute(strength)
			player.pace         = random_attribute(strength)
			player.physical     = random_attribute(strength - 10)
			player.defending    = random_attribute(strength - 20)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.LM, PlayerData.Position.RM:

			player.pace         = random_attribute(strength + 5)
			player.dribbling    = random_attribute(strength + 5)
			player.passing      = random_attribute(strength)
			player.physical     = random_attribute(strength - 5)
			player.shooting     = random_attribute(strength - 5)
			player.defending    = random_attribute(strength - 10)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.LW, PlayerData.Position.RW:

			player.pace         = random_attribute(strength + 8)
			player.dribbling    = random_attribute(strength + 5)
			player.shooting     = random_attribute(strength)
			player.passing      = random_attribute(strength - 5)
			player.physical     = random_attribute(strength - 10)
			player.defending    = random_attribute(strength - 25)
			player.goalkeeping  = random_attribute(10)


		PlayerData.Position.FW, PlayerData.Position.ST:

			player.shooting     = random_attribute(strength + 8)
			player.pace         = random_attribute(strength + 5)
			player.physical     = random_attribute(strength + 3)
			player.dribbling    = random_attribute(strength)
			player.passing      = random_attribute(strength - 10)
			player.defending    = random_attribute(strength - 25)
			player.goalkeeping  = random_attribute(10)

func random_attribute(base:int, variation:=5) -> int:
	return clamp(
		base + randi_range(-variation, variation),
		1,
		99
	)

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
