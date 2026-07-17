extends Node

var current_competition: CompetitionData

func new_game():
	current_competition = CompetitionFactory.create()

func next_matchday():
	var simulator = LeagueSimulator.new()

	simulator.simulate_matchday(current_competition)