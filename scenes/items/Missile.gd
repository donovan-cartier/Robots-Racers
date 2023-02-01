extends Area2D

export var speed = 100
export var steer_force = 100.0

var target = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var explosion = load("res://scenes/Explosion.tscn")

func start(_transform, _target):
	global_transform = _transform
	velocity = transform.x * speed
	target = _target

func _physics_process(delta):
	if global_position.floor() == target.floor():
		var new_explosion = explosion.instance()
		new_explosion.global_position = global_position
		new_explosion.get_node("AnimatedSprite").playing = true
		get_tree().get_root().get_node('Track').add_child(new_explosion)
		queue_free()
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer
