extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass	


func _on_finished() -> void:
	await get_tree().create_timer(30.0).timeout  # 等待 3 秒
	self.play() # Replace with function body.
