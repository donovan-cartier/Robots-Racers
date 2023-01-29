extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var path = get_tree().get_root().get_node("Track/Path")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(path)
	self.points = path.curve.get_baked_points()
	print('populated')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
