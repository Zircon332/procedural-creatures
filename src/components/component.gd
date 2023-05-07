extends Node
class_name Component

var parent : get = _get_parent


func _ready():
	parent = get_parent()


func _get_parent():
	return get_parent()


func _physics_process(_delta):
	physics_process(_delta)


func physics_process(_delta):
	pass
