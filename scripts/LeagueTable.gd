class_name LeagueTable
extends RefCounted

var standings: Array[TeamStanding] = []


func initialize(competition: CompetitionData) -> void:
	standings.clear()

	for team in competition.teams:
		var standing := TeamStanding.new()

		standing.team = team

		standings.append(standing)


func update(match: MatchData) -> void:
	var home = _get_standing(match.home_team)
	var away = _get_standing(match.away_team)

	if home == null or away == null:
		return

	home.played += 1
	away.played += 1

	home.goals_for += match.home_goals
	home.goals_against += match.away_goals

	away.goals_for += match.away_goals
	away.goals_against += match.home_goals

	if match.home_goals > match.away_goals:
		home.wins += 1
		away.losses += 1

		home.points += 3

	elif match.home_goals < match.away_goals:
		away.wins += 1
		home.losses += 1

		away.points += 3

	else:
		home.draws += 1
		away.draws += 1

		home.points += 1
		away.points += 1

	sort_table()


func sort_table() -> void:
	standings.sort_custom(_sort_standings)


func get_position(position: int) -> TeamStanding:
	return standings[position]


func print_table():
	print("==============================")
	print("TABLA")
	print("==============================")

	for i in range(standings.size()):
		var s = standings[i]

		print(
			i + 1, ". ",
			s.team.name,
			" | Pts:", s.points,
			" PJ:", s.played,
			" PG:", s.wins,
			" PE:", s.draws,
			" PP:", s.losses,
			" GF:", s.goals_for,
			" GC:", s.goals_against,
			" DG:", s.goal_difference()
		)


func _get_standing(team: TeamData) -> TeamStanding:
	for standing in standings:
		if standing.team == team:
			return standing

	return null


func _sort_standings(a: TeamStanding, b: TeamStanding) -> bool:
	# 1. Puntos
	if a.points != b.points:
		return a.points > b.points

	# 2. Diferencia de gol
	if a.goal_difference() != b.goal_difference():
		return a.goal_difference() > b.goal_difference()

	# 3. Goles a favor
	if a.goals_for != b.goals_for:
		return a.goals_for > b.goals_for

	# 4. Nombre (desempate estable)
	return a.team.name < b.team.name
