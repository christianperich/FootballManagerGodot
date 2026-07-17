extends Node

func _ready():

	
	randomize()

	var home = TeamData.new()
	home.name = "Colo Colo"
	home.attack = 90
	home.midfield = 90
	home.defense = 90
	home.home_advantage_multiplier = 1.05

	var away = TeamData.new()
	away.name = "Everton"
	away.attack = 90
	away.midfield = 90
	away.defense = 90
	
	#simulate_many(home, away)
	#return
	
	var simulator := MatchSimulator.new()

	for i in range(10):
		var result = simulator.simulate(home, away)
		print_match(result)
	
func print_match(context: MatchContext):

	print("==============================")
	print(context.home_team.name, " vs ", context.away_team.name)
	print("==============================")

	print("Ataques:   ", context.home_attacks, " - ", context.away_attacks)
	print("Ocasiones: ", context.home_chances, " - ", context.away_chances)
	print("Remates:   ", context.home_shots, " - ", context.away_shots)
	print("Goles:     ", context.home_goals, " - ", context.away_goals)

	print("==============================")
	
func simulate_many(home:TeamData, away:TeamData):

	var simulator = MatchSimulator.new()

	var home_wins = 0
	var draws = 0
	var away_wins = 0

	var total_home_goals = 0
	var total_away_goals = 0

	var total_home_shots = 0
	var total_away_shots = 0

	var cantidad_de_partidos = 500
	for i in range(cantidad_de_partidos):

		var result = simulator.simulate(home, away)

		total_home_goals += result.home_goals
		total_away_goals += result.away_goals

		total_home_shots += result.home_shots
		total_away_shots += result.away_shots


		if result.home_goals > result.away_goals:
			home_wins += 1

		elif result.home_goals == result.away_goals:
			draws += 1

		else:
			away_wins += 1



	print("======================")
	print(str(cantidad_de_partidos) + " PARTIDOS")
	print("======================")

	print("Victorias local:",home_wins)
	print("Empates:",draws)
	print("Victorias visita:",away_wins)

	print("----------------------")

	print("Promedio goles:")
	print(
		float(total_home_goals)/cantidad_de_partidos,
		" - ",
		float(total_away_goals)/cantidad_de_partidos
	)

	print("Promedio remates:")
	print(
		float(total_home_shots)/cantidad_de_partidos,
		" - ",
		float(total_away_shots)/cantidad_de_partidos
	)
