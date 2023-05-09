extends CharacterBody2D
class_name BodyJoint


@export var size := 10
@export var gravity := 980
@export var friction := 0.01
@export var angle_max := 100.0
@export var angle_min := 10.0

var angle := 0.0

@export var enable_gravity := true
@export var enable_friction := true

@onready var parent_joint : get = _get_parent_joint
@onready var segment_line := $SegmentLine

var is_dragged = false

func _get_parent_joint():
	if not parent_joint:
		parent_joint = get_parent()
		if not parent_joint is BodyJoint:
			parent_joint = null
	
	return parent_joint


func _ready():
	segment_line.width = get_children_bodies_count()
	segment_line.default_color = Color.RED * (1+get_children_bodies_count()) / 10.0


func get_children_bodies_count():
	var children_body_count = 0
	for child in get_children():
		if child is BodyJoint:
			children_body_count += 1
			children_body_count += child.get_children_bodies_count()
	return children_body_count


func get_node_components():
	var components = []
	for child in get_children():
		if child is Component:
			components.append(child)
	return components


func _process(_delta):
	for child in get_children():
		if child is BodyJoint:
			segment_line.points[1] = child.position


func _physics_process(_delta):
	mouse_drag(_delta)


func mouse_drag(_delta):
	if Input.is_action_just_pressed("left_mouse"):
		if is_mouse_hovering():
			is_dragged = true
			enable_gravity = false
	
	if Input.is_action_just_released("left_mouse"):
		is_dragged = false
		enable_gravity = true
		
	if is_dragged:
		velocity += global_position.direction_to(get_global_mouse_position()) * 50 * global_position.distance_to(get_global_mouse_position()) * _delta


func is_mouse_hovering():
	if global_position.distance_to(get_global_mouse_position()) < size:
		return true
	return false
