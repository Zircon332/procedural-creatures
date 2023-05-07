extends MovementComponent
class_name VerletMovementComponent

## Verlet Integration
## The nodes are linked with the parent

@export var resting_distance := 20
@export var tear_distance := 10
@export var stiffness := 1.5


func physics_process(_delta):
	follow_parent_body(_delta)


func follow_parent_body(_delta):
	move_toward_parent(_delta)


func move_toward_parent(_delta):
	## Velet Integration
	var difference_from_rest = (resting_distance - distance_to_parent()) / distance_to_parent()
	parent.velocity += vector_distance_to_parent() * difference_from_rest * stiffness


func distance_to_parent():
	return parent.position.length()


func vector_distance_to_parent():
	return (parent.global_position - parent.parent_body.global_position)
