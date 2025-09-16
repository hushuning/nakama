#extends CharacterBody2D
#
#@onready var 脚步声: AudioStreamPlayer = $脚步声
#@onready var state_machine = $AnimationTree.get("parameters/playback")
#@export var gravity = 980.0
#var speed = 200.0
#var inputv2 = Vector2.ZERO
#
#func _ready():
	#$AnimationTree.active = true
	#up_direction = Vector2.UP
#func _process(delta):
	## 获取输入方向
	#inputv2 = Vector2.ZERO
	## 应用重力
	##if not is_on_floor(): # 仅在未接触地面时应用重力
	##velocity.y += gravity * delta
	#if Input.is_action_pressed("ui_right"):
		#inputv2.x = 1
	#if Input.is_action_pressed("ui_left"):
		#inputv2.x = -1
	#if Input.is_action_pressed("ui_down"):
		#inputv2.y = 1
	#if Input.is_action_pressed("ui_up"):
		#inputv2.y = -1
	#
	#inputv2 = inputv2.normalized()
#
	## 移动角色
	#if inputv2.length() > 0:
		#脚步声.play()
		#position += inputv2 * delta * speed
		#var anim_dir = inputv2
		#anim_dir.y = - anim_dir.y
		#$AnimationTree.set("parameters/idle/blend_position", anim_dir)
		#$AnimationTree.set("parameters/move/blend_position", anim_dir)
		#state_machine.travel("move")
	#else:
		#state_machine.travel("idle")
	## 调试输出
	#if is_on_wall():
		#print("撞到墙了！位置: ", position, " 速度: ", velocity)
	##if get_slide_collisions().size() > 0:
		##print("碰撞检测: ", get_slide_collisions())	
#
#
#func _physics_process(delta):
	## 应用重力
	##if not is_on_floor():
		##velocity.y += gravity * delta
#
	## 获取水平输入
	#var input_direction = Vector2.ZERO
	#input_direction.x = Input.get_axis("ui_left", "ui_right")
	#input_direction = input_direction.normalized()
#
	## 计算移动向量
	#velocity.x = input_direction.x * speed
#
	## 移动并处理碰撞
	#move_and_slide() # 仅传递 velocity 给 velocity 属性
#
	## 限制角色在地图内
	##var map_size = Vector2(10000, 10000) # 根据 TileMapLayer 大小调整
	##position = position.clamp(Vector2(0, 0), map_size)
#
	## 调试输出
	#if is_on_wall():
		#print("撞到墙了！位置: ", position, " 速度: ", velocity)
	##if get_slide_collisions().size() > 0:
		##print("检测到碰撞: ", get_slide_collisions())
	#if is_on_floor():
		#print("站在地面！位置: ", position)
###########上面是键盘版本的角色移动，下面是手机版本
extends CharacterBody2D

@onready var 脚步声: AudioStreamPlayer = $脚步声
@onready var state_machine = $AnimationTree.get("parameters/playback")
@export var speed: float = 200.0
@export var joystick_path: NodePath

var joystick_node: Control
var inputv2: Vector2 = Vector2.ZERO

func _ready():
	$AnimationTree.active = true
	joystick_node = get_node(joystick_path)
	if not joystick_node:
		push_error("Joystick node not found!")

func _physics_process(delta):
	inputv2 = joystick_node.input_vector

	# 八方向约束
	if inputv2.length() > 0:
		var angle = inputv2.angle()
		var dir8 = Vector2.ZERO
		if abs(angle) < PI/8:
			dir8 = Vector2.RIGHT
		elif abs(angle - PI/4) < PI/8:
			dir8 = Vector2(1, -1).normalized()
		elif abs(angle - PI/2) < PI/8:
			dir8 = Vector2.UP
		elif abs(angle - 3*PI/4) < PI/8:
			dir8 = Vector2(-1, -1).normalized()
		elif abs(angle - PI) < PI/8 or abs(angle + PI) < PI/8:
			dir8 = Vector2.LEFT
		elif abs(angle + 3*PI/4) < PI/8:
			dir8 = Vector2(-1, 1).normalized()
		elif abs(angle + PI/2) < PI/8:
			dir8 = Vector2.DOWN
		elif abs(angle + PI/4) < PI/8:
			dir8 = Vector2(1, 1).normalized()
		else:
			dir8 = inputv2.normalized()
		inputv2 = dir8

	if inputv2.length() > 0:
		# 播放脚步声
		if not 脚步声.playing:
			脚步声.play()

		# 动画
		var anim_dir = inputv2
		$AnimationTree.set("parameters/idle/blend_position", anim_dir)
		$AnimationTree.set("parameters/move/blend_position", anim_dir)
		state_machine.travel("move")

		# 角色移动（Y轴反转，匹配屏幕坐标）
		velocity = Vector2(inputv2.x, -inputv2.y) * speed
	else:
		state_machine.travel("idle")
		if 脚步声.playing:
			脚步声.stop()
		velocity = Vector2.ZERO

	move_and_slide()


func _on__pressed() -> void:
	print("技能释放中click.....") # Replace with function body.
