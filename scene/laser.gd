extends Area2D

var speed = 400.0
var direction=1.0
var active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active: position.x += speed*direction*delta




func _on_body_entered(body: Node2D) -> void:
	if body.name=="guy":
		print("hit") 
		body.take_damage(1)
		active=false
		hide()# Replace with function body.
func fire(from_position: Vector2, target_position: Vector2) -> void:
	global_position = from_position
	direction = sign(target_position.x - from_position.x)

	if direction == 0:
		direction = 1

	active = true
	show()
