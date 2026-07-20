extends Node

var current_season: SeasonData
const CHILE_PRIMERA_A = preload("uid://c67dyr45cjysl")

func _ready():
	new_game()

func new_game():
	#Iniciar la competición y crear los jugadores de cadaequipo
	var competition = CHILE_PRIMERA_A.duplicate(true)
	create_players(competition)

	var season = SeasonData.new()

	season.start(competition)

	current_season = season

func play_current_matchday():
	var matchday = current_season.get_current_matchday()
	if matchday == null:
		print("No hay más partidos por jugar")
		return
		
	print("--------------------------------")
	print("Resultados de la jornada ", matchday.number)
	print("--------------------------------")

	var simulator := MatchSimulator.new()

	for game : MatchData in matchday.matches:
		var result = simulator.simulate(
			game.home_team,
			game.away_team
		)
		
		# GUARDAR RESULTADO
		game.home_goals = result.home_goals
		game.away_goals = result.away_goals
		game.played = true
		game.result = result
		game.matchday = current_season.current_matchday

		#Imprimir el resultado
		print_result(game)		
		
		current_season.league_table.update(game)
	
	current_season.next_matchday()

func create_players(competition : CompetitionData):
	for team:TeamData in competition.teams:
		var generator = PlayersGenerator.new()
		print("Creando los jugadores de " + team.name)
		print("----------------------")
		generator.generate_squad(team)

func print_result(game : MatchData):
	print("%s %s - %s %s" % [
			game.home_team.name, 
			game.home_goals, 
			game.away_goals, 
			game.away_team.name
			])
			
	print("--------------------")
	
	#Imprimir los eventos del partido
	var events = game.result.events
	#print("Numero de eventos: %s" % events.size())
	#print("Matchday: %s" % game.matchday)
	for event in events:
		if event.type == 2:
			var player = game.home_team.players.pick_random()
			print("%s' %s %s (%s)" % [
				event.minute, 
				player.first_name,
				player.last_name,				
				event.attacking_team.abreviation])
	print("--------------------")
