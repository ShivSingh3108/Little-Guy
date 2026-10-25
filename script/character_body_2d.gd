extends CharacterBody2D
var hits_remaining: int = 3
var invincible=false
@export var speed: float = 300.0
@export var acceleration: float = 900.0
@export var deceleration: float = 1100.0
@export var float_height: float = 4.0
@export var float_speed: float = 3.0
@onready var energy_bar = get_tree().current_scene.get_node("hud/health")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var health = 3
var max_health=3
var base_sprite_y: float = 0.0

func _ready() -> void:
	base_sprite_y = sprite.position.y
	sprite.stop()


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(
			direction * speed,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			deceleration * delta
		)

	move_and_slide()

	# Keep Guy inside the screen
	var screen_size := get_viewport_rect().size
	global_position.x = clampf(global_position.x, 30.0, screen_size.x - 30.0)
	global_position.y = clampf(global_position.y, 0.0, screen_size.y - 0.0)


func _process(_delta: float) -> void:
	# Gentle floating animation
	sprite.position.y = base_sprite_y + sin(
		Time.get_ticks_msec() / 1000.0 * float_speed
	) * float_height

func take_damage(amount:int)-> void:
	if invincible  : return
		
	health = max(health-amount,0)
	update_health_display()
	print("guy health:",health)
	
	update_health_display()
	if health<=0:
		
		get_tree().call_deferred("reload_current_scene")
		return
	invincible = true
	
	get_tree().create_timer(1.0).timeout.connect(
	func():invincible=false
	)
func update_health_display() ->void:
	var label=get_tree().current_scene.get_node_or_null("hud/health")
	if label != null:
		var current_health=clampi(health,0,3)
		label.text="❤".repeat(current_health)+"🖤".repeat(3-current_health)
