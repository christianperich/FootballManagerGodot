class_name LeagueTableUI
extends Control

const LEAGUE_TABLE_ROW = preload("uid://cvlgutktknexn")

@onready var rows: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/Rows

func populate(table: Array) -> void:
	if table.is_empty():
		return

	for child in rows.get_children():
		child.queue_free()
		
	var row_header = LEAGUE_TABLE_ROW.instantiate()
	rows.add_child(row_header)
	row_header.create_header()

	var pos := 1
	for stats: TeamStanding in table:
		var row = LEAGUE_TABLE_ROW.instantiate()
		rows.add_child(row)
		row.setup(pos, stats)
		
		pos += 1
