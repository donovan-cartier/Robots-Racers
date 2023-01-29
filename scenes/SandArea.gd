extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SandArea_area_entered(area):
	if area.is_in_group("player"):
		area.set_movement("MASH")


func _on_SandArea_area_exited(area):
	if area.is_in_group("player"):
		area.set_movement("NORMAL")
