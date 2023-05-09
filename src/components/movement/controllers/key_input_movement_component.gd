extends MovementComponent
class_name FollowMouseMovementComponent


@export var speed := 200


func _ready():
	parent.enable_gravity = true


func physics_process(_delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	parent.velocity = velocity * speed
	
#	if (parent.get_global_mouse_position() - parent.global_position).length() > 10:
#			parent.velocity += parent.global_position.direction_to(parent.get_global_mouse_position()) * parent.speed * _delta
