extends AnimatedSprite2D

#@onready var zz: AnimatedSprite2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_finished() -> void:
	get_tree().change_scene_to_file("res://Scen/war.tscn")
