extends Node

func _ready():
	var league := CompetitionData.new()

	league.name = "Liga Chilena"

	for i in range(16):
		var team := TeamData.new()
		team.name = "Equipo %d" % (i + 1)

		league.teams.append(team)

	var generator := FixtureGenerator.new()

	league.teams.shuffle()
	generator.generate(league)

	print_fixture(league)

func print_fixture(league: CompetitionData):
	for matchday in league.matchdays:
		print("===================")
		print("Fecha ", matchday.number)

		for match in matchday.matches:
			print(
				match.home_team.name,
				" vs ",
				match.away_team.name
			)
