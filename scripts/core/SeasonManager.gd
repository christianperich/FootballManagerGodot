class_name SeasonManager
extends Node

var current_season: SeasonData

func start_season(competition: CompetitionData):

	current_season = SeasonData.new()

	current_season.start(
		competition
	)

	print_current_matchday()

func print_current_matchday():

	var matchday = current_season.get_current_matchday()

	print("====================")
	print("JORNADA ", matchday.number)
	print("====================")


	for match in matchday.matches:

		print(
			match.home_team.name,
			" vs ",
			match.away_team.name
		)
