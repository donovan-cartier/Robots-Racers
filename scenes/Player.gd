extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var default_speed = 200
var speed = default_speed
var current_lap = 0
enum move_mode {NORMAL, ALTERNATE, MASH}
enum colors {blue, red, yellow}

var current_move_mode = move_mode.NORMAL
var color
var id
var player_name

var progress_hud

onready var gamerules = get_tree().get_root().get_node("Track/Gamerules")

onready var course_path = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	color = colors.keys()[randi()%colors.size()]
	var colorPath = "res://ressources/robot_" + str(color) + ".png"
	$Sprite.texture = load(colorPath)
	$PlayerInfo/PlayerName.text = player_name
	id = get_tree().get_nodes_in_group("player").size()
	print("player " + str(color) + " => ID: " + str(id))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_move_mode:
		move_mode.NORMAL:
			if Input.is_action_pressed("accelerate"):
				course_path.offset += speed * delta
		move_mode.MASH:
			if Input.is_action_just_pressed("accelerate"):
				course_path.offset += speed * delta
		move_mode.ALTERNATE:
			pass
				
func pass_lap():
	current_lap += 1
	progress_hud.update_hud(self)
	if current_lap >= gamerules.laps_to_win:
		print("PLAYER " + str(color) + " WON !")
	
func set_movement(mode):
	match mode:
		"NORMAL":
			current_move_mode = move_mode.NORMAL
			$PlayerInfo/Spacebar.visible = false
		"MASH":
			current_move_mode = move_mode.MASH
			$PlayerInfo/Spacebar.visible = true
		"ALTERNATE":
			current_move_mode = move_mode.ALTERNATE
