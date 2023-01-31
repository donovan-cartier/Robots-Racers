extends Area2D

enum ITEMS {MISSILE}
var item

# Called when the node enters the scene tree for the first time.
func _ready():
	item = ITEMS.MISSILE


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ItemBox_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
