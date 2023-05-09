extends Node
class_name Component

var parent = null : get = _get_parent


func _get_parent():
	if not parent:
		parent = get_parent()
	
	return parent


func _physics_process(_delta):
	physics_preprocess(_delta)
	physics_process(_delta)
	physics_postprocess(_delta)


func physics_preprocess(_delta):
	pass


func physics_process(_delta):
	pass


func physics_postprocess(_delta):
	pass
