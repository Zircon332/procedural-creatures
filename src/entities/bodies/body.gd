extends CharacterBody2D
class_name Body


@onready var parent_body := get_parent()
@onready var segment_line := $SegmentLine


func _ready():
	segment_line.width = get_children_bodies_count()
	segment_line.default_color = Color(1, 0, 0) * (1+get_children_bodies_count()) / 10.0


func get_children_bodies_count():
	var children_body_count = 0
	for child in get_children():
		if child is Body:
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
		if child is Body:
			segment_line.points[1] = child.position
