extends Control

@export var max_radius: float = 75.0
var input_vector: Vector2 = Vector2.ZERO
@onready var knob: Control = $JoystickKnob

var dragging: bool = false

func _process(delta):
	# 鼠标控制
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_viewport().get_mouse_position()
		if dragging or get_global_rect().has_point(mouse_pos):
			dragging = true
			_update_knob(mouse_pos)
	else:
		dragging = false
		input_vector = Vector2.ZERO
		knob.position = Vector2.ZERO

func _unhandled_input(event):
	# 触屏控制
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if event.is_pressed():
			dragging = true
			_update_knob(event.position)
		else:
			dragging = false
			input_vector = Vector2.ZERO
			knob.position = Vector2.ZERO

func _update_knob(global_pos: Vector2):
	var local_pos = global_pos - global_position
	var len = local_pos.length()
	if len > max_radius:
		local_pos = local_pos.normalized() * max_radius
	input_vector = local_pos / max_radius
	knob.position = local_pos
