@tool
extends AnimatedSprite2D

# frame_offsets 只能用 Variant 类型存字典，因为 Godot 不支持嵌套类型推断
var frame_offsets := {}

func _ready() -> void:
	var file_path := "res://enemy/chongwu/sprite_sheet.tres"  # 改成 String
	frame_offsets = parse_spriteframes_offsets(file_path)
	print("解析的偏移量字典:", frame_offsets)
	
	# 连接帧变化信号
	connect("frame_changed", Callable(self, "_on_frame_changed"))

	# 播放默认动画
	if "kRight" in frame_offsets:
		play("kRight")
	else:
		push_warning("未找到默认动画 kRight")

func parse_spriteframes_offsets(file_path: String) -> Dictionary:
	var offsets := {}
	var sf := ResourceLoader.load(file_path) as SpriteFrames
	if sf == null:
		push_error("无法加载 SpriteFrames: " + file_path)
		return offsets

	for anim_name in sf.get_animation_names():
		offsets[anim_name] = []
		var frames_count := sf.get_frame_count(anim_name)
		for i in range(frames_count):
			var tex := sf.get_frame_texture(anim_name, i)
			var off := Vector2.ZERO
			if tex is AtlasTexture:
				# 从 meta 读取偏移
				if tex.has_meta("frame_offset"):
					off = tex.get_meta("frame_offset")
			offsets[anim_name].append(off)
	return offsets

func _on_frame_changed() -> void:
	var anim := animation
	var idx := frame
	if frame_offsets.has(anim) and idx < frame_offsets[anim].size():
		# 更新 sprite 的位置偏移量
		position = frame_offsets[anim][idx]
