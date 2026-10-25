extends CharacterBody2D


@onready var sprite =$AnimatedSprite2D
var health =5


func _physics_process(_delta: float) -> void:
	sprite.play("oidle")

func face_player(player: Node2D) -> void:
	if player.global_position.x < global_position.x:
		$AnimatedSprite2D.flip_h = true
		
	if player.global_position.x >global_position.x:
		$AnimatedSprite2D.flip_h = true
	
func take_damage(amount:int)-> void:
	if health <= 0:
		return
	health = max(health- amount,0)
	health= max(health,0)
	print("owner health:",health)
	var bar=get_tree().current_scene.get_node_or_null("owner/hpbar")
	if bar != null:
		bar.value=health
	if health<=0:
		print("owner defeat")
		var level=get_tree().current_scene
		if level.has_node("Timer"):
			level.get_node("Timer").stop()
		queue_free()
		
		if level.has_method("play_owner_defeat"):
			level.play_owner_defeat()
		
