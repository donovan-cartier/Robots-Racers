extends Area2D

var ITEMS = ["MISSILE", "BOOST"]
var item_in_box

# Called when the node enters the scene tree for the first time.
func _ready():
	item_in_box = ITEMS[1]
	print(item_in_box)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ItemBox_area_entered(area):
	if area.is_in_group("player"):
		area.get_item(item_in_box)
		queue_free()
