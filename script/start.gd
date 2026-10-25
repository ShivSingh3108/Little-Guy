extends Node2D

var near_book = false
var reading = false
var page = 0

var pages = [
	"Project L177L3 4U\nAKA: Little Guy",
	"I discovered an unusual energy source deep in the jungle.",
	"After experimenting, I found that its energy could power Earth for years through the core reactor.",
	"But the energy was too powerful. No cable or wire could withstand it.",
	"So I created a robot capable of absorbing the energy and carrying it to the core reactor.",
    "Next step: Command Little Guy to absorb the energy and deliver it to the reactor."
]

@onready var panel = $CanvasLayer/Panel
@onready var story = $CanvasLayer/Panel/Label
@onready var continue_hint = $CanvasLayer/Panel/Label2


func _ready() -> void:
	panel.hide()
	continue_hint.hide()


func _process(_delta: float) -> void:
	if near_book and Input.is_action_just_pressed("interact"):
		if not reading:
			reading = true
			page = 0
			panel.show()
			story.show()
			story.text = pages[page]
			continue_hint.text = "Press E to continue"
			continue_hint.show()
		else:
			page += 1

			if page >= pages.size():
				reading = false
				panel.hide()
				$book.queue_free()
				get_tree().change_scene_to_file("res://scene/guy.tscn")
			else:
				story.text = pages[page]
			
func _on_book_body_entered(body: Node2D) -> void:
	if body.name == "guy":
		near_book = true

		if not reading:
			panel.show()
			story.hide()
			continue_hint.text = "Press E to read"
			continue_hint.show()


func _on_book_body_exited(body: Node2D) -> void:
	if body.name == "guy":
		near_book = false
		reading = false
		panel.hide()
