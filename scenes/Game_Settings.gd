extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_name_edit_res = preload("res://scenes/Player_name_edit.tscn")
var players_num = 1
var colors = ["blue", "red", "yellow"]

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
	for player_info in get_tree().get_nodes_in_group("player_info_select"):
		var player_name = player_info.get_node("Player_name_edit").text
		var player_color = player_info.get_node("Color").selected
		var player_controller = player_info.get_node("InputMode").selected
		Gamerules.players.append([player_name, player_color, player_controller])
	Gamerules.players_num = Gamerules.players.size()
#	Gamerules.remaining_players_to_load = players_num
	get_tree().change_scene("res://scenes/Track.tscn")
