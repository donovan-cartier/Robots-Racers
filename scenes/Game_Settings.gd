extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_name_edit_res = preload("res://scenes/Player_name_edit.tscn")
var players_num = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Add_Player_pressed():
	$Players.add_child(player_name_edit_res.instance())
	players_num += 1

func _on_Start_Game_pressed():
#	Gamerules.laps_to_win
	for player_name in get_tree().get_nodes_in_group("player_name_edit"):
		Gamerules.players.append(player_name.text)
	Gamerules.players_num = Gamerules.players.size()
#	Gamerules.remaining_players_to_load = players_num
	get_tree().change_scene("res://scenes/Track.tscn")
