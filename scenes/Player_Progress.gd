extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var gamerules = get_tree().get_root().get_node("Track/Gamerules")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup(player):
	$PlayerSprite.texture = player.get_node("Sprite").texture
	$Lap.text = str(player.current_lap) + "/" + str(gamerules.laps_to_win)
	player.progress_hud = self
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_hud(player):
	$Lap.text = str(player.current_lap) + "/" + str(gamerules.laps_to_win)
