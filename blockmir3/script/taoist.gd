extends Node2D

@onready var state_machine = $AnimationTree.get("parameters/playback")

var speed = 200.0
var inputv2 = Vector2.ZERO

func _ready():
	$AnimationTree.active = true

func _process(delta):
	# 获取输入方向
	inputv2 = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		inputv2.x = 1
	if Input.is_action_pressed("ui_left"):
		inputv2.x = -1
	if Input.is_action_pressed("ui_down"):
		inputv2.y = 1
	if Input.is_action_pressed("ui_up"):
		inputv2.y = -1
	
	inputv2 = inputv2.normalized()
	
	# 移动角色
	if inputv2.length() > 0:
		position += inputv2 * delta * speed
		var anim_dir = inputv2
		anim_dir.y = - anim_dir.y
		$AnimationTree.set("parameters/idle/blend_position", anim_dir)
		$AnimationTree.set("parameters/move/blend_position", anim_dir)
		state_machine.travel("move")
	else:
		state_machine.travel("idle")
