extends Area2D

var guy_nearby = false
var activated = false

@onready var ending_panel =$CanvasLayer/Panel
@onready var ending_text =$CanvasLayer/Panel/Label

func _ready() -> void:
	ending_panel.hide()
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "guy":
		guy_nearby = true
		print("Press E to activate the reactor")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "guy":
		guy_nearby = false

func _process(_delta: float) -> void:
	if guy_nearby and not activated and Input.is_action_just_pressed("interact"):
		activated = true
		ending_text.text = "Reactor activated!\nEarth's energy crisis is over.\n\nThank you for playing!"
		ending_panel.show()
		get_tree().current_scene.get_node("restart").show()
		print("Reactor activated!")
func _on_resb_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/start.tscn")
		
		
