class_name Interactable
extends StaticBody3D

enum ObjectType {
	Item,
	Look
}

@export var object_name: String  = ""
@export var object_type: ObjectType
@export_multiline var description: String  = ""
@export_multiline var dialog_player: Array[String] = []

var rotating = false
var looking = false

var prev_mouse_position
var next_mouse_position

var prev_position
var prev_rotation

func _physics_process(delta):
	if Input.is_action_just_pressed("look") && object_type == ObjectType.Look:
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("look") && object_type == ObjectType.Look:
		rotating = false
	if rotating:
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_y((next_mouse_position.x - prev_mouse_position.x) * .05 * delta)
		rotate_z(-(next_mouse_position.y - prev_mouse_position.y) * .05 * delta)
		rotate_x((next_mouse_position.y - prev_mouse_position.y) * .05 * delta)
		
func look_object():
	looking = true
	prev_position = global_position
	prev_rotation = global_rotation
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	var show = get_node("/root/Main/Player/UI/SubViewportContainer/SubViewport")
	get_parent().remove_child(self)
	show.add_child(self)
	position = Vector3.ZERO
	
func return_object():
	looking = false
	var show = get_node("/root/Main")
	get_parent().remove_child(self)
	show.add_child(self)
	global_position = prev_position
	global_rotation = prev_rotation
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
