extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var players = get_tree().get_nodes_in_group("player")
onready var player_progress = load("res://scenes/Player_Progress.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("players are" + str(players))
	for player in players:
		var pp_hud = player_progress.instance()
		$Players.add_child(pp_hud)
		pp_hud.setup(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
