extends CharacterBody2D

@export var move_speed := 200.0

func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO

	# 读取输入方向
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# 如果有输入，归一化方向以防对角方向加速
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	velocity = input_vector * move_speed
	move_and_slide()
