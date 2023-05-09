extends MovementComponent
class_name VerletMovementComponent

## Verlet Integration
## The nodes are linked with the parent

@export var resting_distance := 10
@export var tear_distance := 20
@export var stiffness := 5


func physics_process(_delta):
	if parent.get("parent_joint"):
		solve_verlet(_delta)


func solve_verlet(_delta):
	var difference_from_rest = (resting_distance - distance_to_parent()) / distance_to_parent()
	var velocity_offset = vector_distance_to_parent() * difference_from_rest * stiffness * 0.5
	
	parent.velocity += velocity_offset 
	parent.parent_joint.velocity -= velocity_offset
	
	if distance_to_parent() > tear_distance:
		parent.position = parent.position.normalized() * tear_distance
	
#	if distance_to_parent() > tear_distance:
#		var children_bodies = parent.get_children_bodies(false)
#		for body in children_bodies:
#			var pos = body.global_position
#			parent.remove_child(body)
#			get_tree().root.get_child(0).add_child(body)
#			parent.segment_line.visible = false
#			body.parent_joint = null
#			body.global_position = pos


func distance_to_parent():
	return parent.position.length()


func vector_distance_to_parent():
	return (parent.global_position - parent.parent_joint.global_position)
