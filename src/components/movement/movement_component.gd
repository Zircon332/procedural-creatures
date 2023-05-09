extends Component
class_name MovementComponent


var _prev_global_pos := Vector2.ZERO


func physics_preprocess(_delta):
	_prev_global_pos = parent.global_position
	apply_gravity(_delta)


func physics_postprocess(_delta):
	apply_friction(_delta)
	apply_angle_restrictions()
	parent.move_and_slide()
	unmove_children_bodies(_prev_global_pos)


func apply_gravity(_delta):
	if not parent.enable_gravity:
		return
	
	parent.velocity.y += parent.gravity * _delta


func apply_friction(_delta):
	if not parent.enable_friction:
		return
	
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, parent.friction)


func unmove_children_bodies(_prev_global_pos):
	# Maintain children global position
	var parent_movement = parent.global_position - _prev_global_pos
	var children = parent.get_children()
	for child in children:
		if child is BodyJoint:
			child.global_position -= parent_movement


func apply_angle_restrictions():
	calculate_angle()
	
	var angle_difference = 0
	if abs(parent.angle) > parent.angle_max:
		angle_difference = abs(abs(parent.angle) - parent.angle_max)
	
#	parent.velocity = parent.velocity.rotated(deg_to_rad(-angle_difference))


func calculate_angle():
	var angle = atan2(-parent.position.y, -parent.position.x)
	
	parent.angle = rad_to_deg(angle)
