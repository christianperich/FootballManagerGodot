class_name FixtureGenerator
extends RefCounted


func generate(competition: CompetitionData) -> void:
	competition.matchdays.clear()

	var teams = competition.teams.duplicate()

	# Si la cantidad es impar agregamos un descanso (BYE)
	if teams.size() % 2 != 0:
		teams.append(null)

	var total_rounds = teams.size() - 1
	var matches_per_round = teams.size() / 2

	#=========================
	# Primera rueda
	#=========================

	for each_round in range(total_rounds):
		var matchday := MatchdayData.new()
		matchday.number = each_round + 1

		for i in range(matches_per_round):
			var home = teams[i]
			var away = teams[teams.size() - 1 - i]

			if home == null or away == null:
				continue

			var game := MatchData.new()

			# Alternar localía para equilibrar el calendario
			if each_round % 2 == 0:
				game.home_team = home
				game.away_team = away
			else:
				game.home_team = away
				game.away_team = home

			game.matchday = matchday.number

			matchday.matches.append(game)

		competition.matchdays.append(matchday)

		_rotate_teams(teams)

	#=========================
	# Segunda rueda
	#=========================

	var first_leg = competition.matchdays.duplicate()

	for matchday in first_leg:
		var second := MatchdayData.new()

		second.number = competition.matchdays.size() + 1

		for match in matchday.matches:
			var reverse := MatchData.new()

			reverse.home_team = match.away_team
			reverse.away_team = match.home_team

			reverse.matchday = second.number

			second.matches.append(reverse)

		competition.matchdays.append(second)


func _rotate_teams(teams: Array) -> void:
	var last = teams.pop_back()

	teams.insert(1, last)