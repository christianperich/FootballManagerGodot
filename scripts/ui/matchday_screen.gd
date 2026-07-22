extends Control

@onready var league_table: LeagueTableUI = $HBoxContainer/LeagueTable

@onready var match_list: ScrollContainer = $HBoxContainer/MatchList
@onready var v_box_container: VBoxContainer = $HBoxContainer/MatchList/MarginContainer/VBoxContainer
const MATCH_ITEM = preload("uid://b438xdxc2k6m2")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	league_table.populate(GameManager.current_season.league_table.standings)
	
func show_league_table():
	league_table.populate(GameManager.current_season.league_table.standings)
	
func show_results():
	for child in v_box_container.get_children():
		child.queue_free()

	#mostrar los resultados de la jornada actual
	var matchday = GameManager.current_season.get_current_matchday()
	
	if matchday == null:
		return
		
	for match in matchday.matches:
		var match_item = MATCH_ITEM.instantiate()
		v_box_container.add_child(match_item)
		match_item.setup(match)
