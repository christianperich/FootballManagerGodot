extends Resource
class_name SeasonData

var competition: CompetitionData
var league_table: LeagueTable
var current_matchday: int = 1

func start(_competition):
	competition = _competition.duplicate(true)
	
	league_table = LeagueTable.new()
	league_table.initialize(competition)

	var fixture_generator := FixtureGenerator.new()
	fixture_generator.create_fixtures(competition)

	print("Temporada creada")
	print("Fechas:", competition.matchdays.size())
	
	#print_fixture()
	#print_current_matchday()
	
func print_fixture():
	for matchday in competition.matchdays:
		print("====================")
		print("FECHA ", matchday.number)
		print("====================")

		for match in matchday.matches:
			print(
				match.home_team.name,
				" vs ",
				match.away_team.name
			)

func get_current_matchday() -> MatchdayData:
	for matchday in competition.matchdays:
		if matchday.number == current_matchday:
			return matchday

	return null

func print_current_matchday():
	var matchday = get_current_matchday()

	if matchday == null:
		print("No existe la fecha")
		return


	print("================")
	print("FECHA ", matchday.number)
	print("================")


	for match in matchday.matches:
		print(
			match.home_team.name,
			" vs ",
			match.away_team.name
		)

func next_matchday():
	current_matchday += 1
	#league_table.print_table()
	#print_current_matchday()
