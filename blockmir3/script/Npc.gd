extends CharacterBody2D
class_name Npc

@export var display_name: String = ""       # Inspector里显示的角色名字
@export var idle_anim: String = "npc1"      # 待机动画
@export var hover_anim: String = "npc1_2"    # 悬停动画

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var hover_area: Area2D = $HoverArea   # 新增节点：检测悬停的 Area2D
#var on_click_callback: Callable = null
@export var popup_scene: PackedScene  # Inspector 设置你的弹窗场景
var popup_instance: Control = null
var count : int;
func _ready():
	# 初始化名字
	if display_name == "":
		display_name = name
	label.text = display_name

	# 连接 Area2D 的鼠标信号
	hover_area.connect("mouse_entered", Callable(self, "_on_hover_entered"))
	hover_area.connect("mouse_exited", Callable(self, "_on_hover_exited"))
	#_play_if_exists(idle_anim)
	hover_area.connect("input_event", Callable(self, "_on_area_input"))

func _on_hover_entered() -> void:
	print("鼠标悬停在角色: ", display_name)
	#if sprite.has_animation(hover_anim):
	sprite.play(hover_anim)

func _on_hover_exited() -> void:
	#if sprite.has_animation(idle_anim):
	sprite.play(idle_anim)
func _on_area_input(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("点击角色: ", display_name)
		_show_popup()
		print(!count)
		if popup_instance.visible and count:
			popup_instance.visible = false
		else:
			popup_instance.visible = true	
		count +=1
		#if on_click_callback:
			#on_click_callback.call(self)   # 执行自定义回调	
		#if display_name == "链上管理员":
			#_show_popup()
func _show_popup():
	if popup_scene == null:
		return
	#else:
			
	if popup_instance == null:
		popup_instance = popup_scene.instantiate()
		get_tree().current_scene.add_child(popup_instance)

	if popup_instance.has_method("show_popup"):
		popup_instance.call("show_popup", display_name)	
		
