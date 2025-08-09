extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#velocity: Vector2 = Vector2.ZERO
var gravity = 0.0  # 关闭重力
func _ready() -> void:
	print("ready敌人")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta  # gravity为0，velocity.y不会变化
	move_and_slide()
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
