extends Area2D

@export var speed: float = 300.0

func _process(delta: float) -> void:
	global_position.x -= speed * delta

	if global_position.x < -500:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
	set_deferred("monitoring",false)
	call_deferred("queue_free")
