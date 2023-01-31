extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var paths = get_tree().get_nodes_in_group("player_path")
var player_node = load("res://scenes/Player.tscn")
var game_hud = load("res://scenes/Game_HUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var available_paths = paths
	print(Gamerules.players)
	
#	Instantiate players
	var i = 0
	for player_info in Gamerules.players:
		var new_player = player_node.instance()
		new_player.player_name = player_info[0]
		new_player.color = new_player.colors[player_info[1]]
		paths[i].add_child(new_player)
		new_player.rotation_degrees = 90.0
		i += 1
		
#	Load HUD
	add_child(game_hud.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
