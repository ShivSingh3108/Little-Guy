extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node2D) -> void:
	if body.name=="guy":
		body.unlock_jet()
		queue_free()
		print("jet")
	get_tree().change_scene_to_file("res://scene/sky.tscn")
