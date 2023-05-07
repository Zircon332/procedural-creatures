extends Component
class_name MovementComponent

@export var gravity := 980
@export var friction := 0.1

@export var has_gravity := true
@export var has_friction := true


func _physics_process(_delta):
	var prev_global_pos = parent.global_position
	
	apply_gravity(_delta)
	
	# Moves based on implementation
	physics_process(_delta)
	
	apply_friction(_delta)
	parent.move_and_slide()
	
	unmove_children_bodies(prev_global_pos)


func apply_gravity(_delta):
	if not has_gravity:
		return
	
	parent.velocity.y += gravity * _delta


func apply_friction(_delta):
	if not has_friction:
		return
		
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, friction)


func unmove_children_bodies(prev_global_pos):
	# Maintain children global position
	var parent_movement = parent.global_position - prev_global_pos
	var children = parent.get_children()
	for child in children:
		if child is Body:
			child.global_position -= parent_movement
