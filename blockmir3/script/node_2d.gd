extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("进来了")
	get_tree().change_scene_to_file("res://enemy.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
