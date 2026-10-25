extends Area2D

var guy_nearby = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "guy":
		guy_nearby = true
		print("Press E to activate the reactor")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "guy":
		guy_nearby = false
		print("Moved away from reactor")

func _process(_delta: float) -> void:
	if guy_nearby and Input.is_action_just_pressed("interact"):
		print("Reactor activated!")
