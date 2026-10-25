extends CanvasLayer
signal dialogue_finished

@onready var diatext: Label = $Panel/diatext

var lines = [
	"Little Guy: Move aside old man (press space or enter)",
	"kalik: What!!!! is that you little guy?",
	"kalik: I thought you got destroyed",
	"Little Guy: I don't know you sir",
	"Little Guy: Move aside ,I have to absord that energy",
	"kalik: No need guy , i am shutting it down",
	"Little Guy: Its my order to absord that ",
	"kalik: And now i order you to don't",
	"Little Guy: I dont take command from you sir , I follow this book",
	"kalik: Wait , what!!.....",
	"kalik: I see you lost your memory, and somehow found that book and now you obey it",
	"kalik: Sorry Lil guy , I wont let you do this.",
	"Little Guy: Obstruction Detected : Attack Mode On use J"
]

var current_line = 0

func _ready() -> void:
	diatext.text = lines[current_line]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		current_line += 1

		if current_line < lines.size():
			diatext.text = lines[current_line]
		else:
			diatext.text = ""
			$Panel.hide()
			dialogue_finished.emit()
			print("Dialogue finished!")
