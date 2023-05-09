extends MovementComponent
class_name VerletMovementComponent

## Verlet Integration
## The nodes are linked with the parent

@export var resting_distance := 20
@export var tear_distance := 40
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


func distance_to_parent():
	return parent.position.length()


func vector_distance_to_parent():
	return (parent.global_position - parent.parent_joint.global_position)
