extends Node2D

const PROJECTILE_SCENE = preload("res://scene/projectile.tscn")

@export var duration: float = 35.0
@export var spawn_interval: float = 0.9

@onready var guy: CharacterBody2D = $guy2
var dialogue = [
	[1.0, "Kalik: The Owner discovered something revolutionary..."],
	[5.0, "Kalik: A source of energy that could power Earth for years. And everyone praised HIM."],
	[10.0, "Kalik: I was jealous. So I destroyed his lab... and killed the Owner."],
	[20.0, "Kalik: Now he's gone. His lab is gone. You're the only one left."],
	[25.0, "Kalik: Dodge this if you can"],
	[30.0, "Kalik: ahhh......S.as.help(CRASHING)"],
	[33.0, "KALIK CRASHED INTO REACTOR BUILDING"]
	
]

var dialogue_index: int = 0

	
var elapsed: float = 0.0
var spawn_timer: float = 0.0
var finished: bool = false


func _ready() -> void:
	randomize()
	$guy2.global_position = Vector2(
		150.0,
		get_viewport_rect().size.y / 2.0
	)
	$CanvasLayer/Label.text=""

func _process(delta: float) -> void:
	if finished:
		return

	elapsed += delta
	spawn_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_projectile()

	if elapsed >= duration:
		finish_sequence()
	if dialogue_index < dialogue.size():
		if elapsed >= dialogue[dialogue_index][0]:
			$CanvasLayer/Label.text = dialogue[dialogue_index][1]
			dialogue_index += 1

func spawn_projectile() -> void:
	var projectile = PROJECTILE_SCENE.instantiate()
	add_child(projectile)

	var screen_size = get_viewport_rect().size

	projectile.global_position = Vector2(
		screen_size.x + 40.0,
		randf_range(20.0, screen_size.y / 2.0)
	)

func finish_sequence() -> void:
	if finished:
		return
	finished = true

	# Stop Guy and remove remaining projectiles
	guy.set_physics_process(false)
	guy.set_process(false)

	for projectile in get_children():
		if projectile is Area2D and projectile != guy:
			projectile.queue_free()
	get_tree().change_scene_to_file("res://scene/ending.tscn")
	print("35 seconds survived!")
	print("Ready for Kalik's crash sequence.")
