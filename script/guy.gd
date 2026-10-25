extends CharacterBody2D


const SPEED = 140.0
const JUMP_VELOCITY = -400.0
var gravity = 980
var health = 3
var max_health=3
var invincible=false
var defeated=false
var jet_unlocked=false
var jet_used=false
var jet_boost=-550.0

@onready var sprite =$AnimatedSprite2D
var attacking = false

func _physics_process(delta: float) -> void:
	if defeated:
		return# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	if not attacking:
		if direction !=0 :
			sprite.flip_h = direction<0
			if sprite.animation != "walk":
				sprite.play("walk")	
		else:
			if sprite.animation != "idle":
				sprite.play("idle")


		
	if Input.is_action_just_pressed("attack") and not attacking:
		var level= get_tree().current_scene
		if not level.fighting:
			return
		attacking =true
		sprite.play("attack")
		
		var owner = get_tree().current_scene.get_node_or_null("owner")
		print("owner",owner!=null)
		print("Distance: ",global_position.distance_to(owner.global_position))
		print(global_position)
		print(owner.global_position)
		if owner !=null:
			if global_position.distance_to(owner.global_position)<50:
				print("inrange")
				owner.take_damage(1)
	move_and_slide()
	if jet_unlocked and Input.is_action_just_pressed("fly"):
		velocity.y = -250.0
		jet_used=true
		print("jet active")
	if is_on_floor():
		jet_used=false
func take_damage(amount:int)-> void:
	if invincible or defeated : return
		
	health = max(health-amount,0)
	update_health_display()
	print("guy health:",health)
	
	update_health_display()
	if health<=0:
		
		defeated=true
		get_tree().current_scene.get_node("restart").show()
		velocity=Vector2.ZERO
		print("guy defeated")
		return
	invincible = true
	
	get_tree().create_timer(1.0).timeout.connect(
	func():invincible=false
	)


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation=="attack":
		attacking = false
		
func update_health_display() ->void:
	var label=get_tree().current_scene.get_node_or_null("hud/health")
	if label != null:
		var current_health=clampi(health,0,3)
		label.text="o".repeat(current_health)+"x".repeat(3-current_health)

func unlock_jet() ->void:
	jet_unlocked = true
	print("jet")
