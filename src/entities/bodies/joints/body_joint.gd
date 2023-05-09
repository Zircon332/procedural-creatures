extends CharacterBody2D
class_name BodyJoint


@export var size := 10
@export var gravity := 980
@export var friction := 0.1
@export var angle_max := 100.0
@export var angle_min := 10.0

var angle := 0.0

@export var enable_gravity := true
@export var enable_friction := true

@onready var parent_joint : get = _get_parent_joint
@onready var segment_line := $SegmentLine


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
