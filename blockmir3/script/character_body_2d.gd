extends CharacterBody2D



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var name_label = $Label
func _ready() -> void:
	#connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	name_label.text = "宠物管理员"
	#name_label.position = Vector2(0, 0)  # 放到角色头顶
func _physics_process(delta: float) -> void:
	# Add the gravity.
	pass
	
	#move_and_slide()


func _on_mouse_entered() -> void:
	print("5678")
	print("当前节点名称: ", name)
	animated_sprite_2d.play("npc1_2")
 # Replace with function body.


func _on_mouse_exited() -> void:
	animated_sprite_2d.play("npc1")




@onready var collision_shape = $CollisionShape2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("检测到点击: ", event.position, " 全局鼠标位置: ", get_global_mouse_position())
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsPointQueryParameters2D.new()
		query.position = event.position
		query.collide_with_bodies = true
		query.collision_mask = 1  # 确保只检测 Layer 1
		var result = space_state.intersect_point(query)
		print("查询结果: ", result)

		if result.size() > 0:
			for hit in result:
				if hit.collider is CharacterBody2D:
					print("点击了对象: ", hit.collider.name, " (ID: ", hit.collider.get_instance_id(), ")")
					#if hit.collider.has_node("AudioStreamPlayer"):
						#var audio_player = hit.collider.get_node("AudioStreamPlayer")
						#if audio_player.stream:
							#audio_player.play()
							#print("播放音频: ", hit.collider.name)
				#else:
					#print("命中非 CharacterBody2D: ", hit.collider.name)
		else:
			print("无碰撞检测到")

		
