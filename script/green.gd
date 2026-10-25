extends Area2D
var fighting=false
var owner_defeated=false
@onready var dialogue_ui = $"dialogue ui"
# Called when the node enters the scene tree for the first time.
func _on_body_entered(body: Node2D)-> void:
	if body.name=="guy":
		print("encountered")
		dialogue_ui.show()

func _on_dialogue_ui_dialogue_finished() -> void:
	fighting=true
	
	print("fight")
	var owner_node=get_node_or_null("owner")
	if owner_node!= null:
		owner_node.face_player($guy)
	$Timer.start()
	
func fire_owner_laser() -> void:
	var laser=get_node_or_null("owner/laser")
	var _owner_node=get_node_or_null("owner")
	var _guy_node=get_node_or_null("guy")
	if laser!=null:
		laser.fire($owner.global_position,$guy.global_position)
	print("owner:" ,get_node_or_null("owner"))
	print("guy:" ,get_node_or_null("guy"))

func _on_timer_timeout() -> void:
	if fighting:
		fire_owner_laser()
		$Timer.start() 
func play_owner_defeat()-> void:
	$escape/flash.show()
	$escape/msg.hide()
	$escape/escapetimer.start()
	
func _on_escapetimer_timeout() -> void:
	if owner_defeated:
		return
	$escape/flash.hide()
	$escape/msg.show()
	$escape/msgtimer.start()
	print("owner escaped") # Replace with function body.

func _on_msgtimer_timeout()->void:
		$escape/msg.hide()
		print("HIDDEN")
	


func _on_resb_pressed() -> void:
	get_tree().reload_current_scene()
