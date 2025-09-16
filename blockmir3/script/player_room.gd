extends Node2D

#extends CharacterBody2D

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var name_label = $Label
#@onready var collision_shape = $CollisionShape2D
@onready var label链: Label = $链上管理员/Label
@onready var collision_shape_2d链: CollisionShape2D = $链上管理员/CollisionShape2D
@onready var animated_sprite_2d链: AnimatedSprite2D = $链上管理员/AnimatedSprite2D
@onready var animated_sprite_2d宠: AnimatedSprite2D = $宠物管理员/AnimatedSprite2D
@onready var collision_shape_2d宠: CollisionShape2D = $宠物管理员/CollisionShape2D
@onready var label宠: Label = $宠物管理员/Label

func _ready() -> void:
	label链.text = "链上管理员"
	label宠.text = "宠物管理员"
	
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))

#func _physics_process(delta: float) -> void:
	#extends Node2D

#func _process(delta):
	#extends Node2D


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_2d().direct_space_state

	var params = PhysicsPointQueryParameters2D.new()
	params.position = mouse_pos
	params.collide_with_areas = true
	params.collide_with_bodies = true
	params.collision_mask = 1 << 1   # 只检测 Layer 2（角色）

	var results = space_state.intersect_point(params)

	for r in results:
		var collider = r.collider
		# 有时候返回的是 CollisionObject2D，需要往上找父节点
		var top = collider
		while top and not (top is CharacterBody2D):
			top = top.get_parent()
		if top and top is CharacterBody2D:
			print("鼠标悬停在角色: ", top.name)
			return


#func _on_mouse_entered() -> void:
	#print("2345")
	#print("当前节点名称: ", name)
	#animated_sprite_2d.play("npc1_2")
#
#func _on_mouse_exited() -> void:
	#print("5678")
	#print("当前节点名称: ", name)
	#animated_sprite_2d.play("npc1")

#func _unhandled_input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print("检测到点击: ", event.position, " 全局鼠标位置: ", get_global_mouse_position(), " 节点位置: ", global_position, " 当前层: ", collision_layer)
		#var space_state = get_world_2d().direct_space_state
		#if not space_state:
			#print("空间状态无效")
			#return
		#var query = PhysicsPointQueryParameters2D.new()
		#query.position = get_global_mouse_position()  # 使用全局坐标
		#query.collide_with_bodies = true
		#query.collision_mask = collision_layer  # 动态匹配当前节点的层
		#var result = space_state.intersect_point(query)
		#print("查询结果: ", result)
#
		#if result.size() > 0:
			#for hit in result:
				#if hit.collider is CharacterBody2D:
					#print("点击了对象: ", hit.collider.name, " (ID: ", hit.collider.get_instance_id(), ")")
					##if hit.collider.has_node("AudioStreamPlayer"):
						##var audio_player = hit.collider.get_node("AudioStreamPlayer")
						##if audio_player.stream:
							##audio_player.play()
							##print("播放音频: ", hit.collider.name)
				#else:
					#print("命中非 CharacterBody2D: ", hit.collider.name)
		#else:
			#print("无碰撞检测到")
#

func _on_宠物管理员_mouse_entered() -> void:
	#print("2345")
	print("当前节点名称: ", name)
	animated_sprite_2d宠.play("npc1_2")


func _on_宠物管理员_mouse_exited() -> void:
	print("当前节点名称: ", name)
	animated_sprite_2d宠.play("npc1")


func _on_链上管理员_mouse_entered() -> void:
	#print("2345")
	print("当前节点名称: ", name)
	animated_sprite_2d链.play("npc1_2")


func _on_链上管理员_mouse_exited() -> void:
	print("当前节点名称: ", name)
	animated_sprite_2d链.play("npc1")
