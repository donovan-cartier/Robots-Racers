extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var default_speed = 200
var speed = default_speed
var current_lap = 0
enum move_mode {NORMAL, ALTERNATE, MASH}
var colors = ["blue", "red", "yellow"]

var current_move_mode = move_mode.NORMAL
var color
var id
var player_name
var items = []
var is_aiming_missile = false

var missile = load("res://scenes/items/Missile.tscn")

var progress_hud

onready var gamerules = get_tree().get_root().get_node("Track/Gamerules")

onready var course_path = get_parent()

var cursor_aim = load("res://ressources/cursor_aim_32.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var colorPath = "res://ressources/robot_" + str(color) + ".png"
	$Sprite.texture = load(colorPath)
	$PlayerInfo/PlayerName.text = player_name
	id = get_tree().get_nodes_in_group("player").size()
	print("player " + str(color) + " => ID: " + str(id))
	$AnimationPlayer.play("Move")

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
	
	if Input.is_action_just_pressed("use_item"):
		if is_aiming_missile:
			fire_missile()
		elif !items.empty():
			var item_to_use = items[0]
			match item_to_use:
				"MISSILE":
					use_missile()
				"BOOST":
					use_boost()
				
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




################ITEMS################
func get_item(item):
	print(item)
	items.append(item)
	
func remove_item(id = 0):
	items.remove(id)
	
#MISSILE
func use_missile():
	Input.set_custom_mouse_cursor(cursor_aim)
	is_aiming_missile = true

func fire_missile():
	var mouse_pos = get_viewport().get_mouse_position()
	var missile_instance = missile.instance()
	missile_instance.global_position = mouse_pos
	get_tree().get_root().get_node("Track").add_child(missile_instance)
	print("missile shot")
	is_aiming_missile = false
	Input.set_custom_mouse_cursor(null)
	remove_item()

#BOOST
func use_boost():
	speed = 300
	var boost_timer = Timer.new()
	boost_timer.wait_time = 1
	boost_timer.connect("timeout", self, "_boost_timeout", [boost_timer])
	add_child(boost_timer)
	boost_timer.start()
	remove_item()

func _boost_timeout(timer):
	print("timeout")
	timer.queue_free()
	speed = default_speed

