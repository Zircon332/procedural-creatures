extends MovementComponent
class_name KeyInputMovementComponent


func _ready():
	has_gravity = false


func physics_process(delta):
	if (parent.get_global_mouse_position() - parent.global_position).length() > 10:
			parent.velocity += parent.global_position.direction_to(parent.get_global_mouse_position()) * parent.speed * delta
