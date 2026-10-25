extends Area2D

@export_file("*.tscn") var next_scene: String

var triggered: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if triggered or body.name != "guy":
		return

	triggered = true
	get_tree().change_scene_to_file("res://scene/green.tscn")
