extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var path

# Called when the node enters the scene tree for the first time.
func _ready():
	print(path)
	var pathLoad = get_node(path)
	self.points = pathLoad.curve.get_baked_points()
	print('populated')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
