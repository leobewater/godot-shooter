extends CharacterBody2D


var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_near: bool = false

func _process(delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()


func _on_attack_area_body_entered(_body):
	player_near = true


func _on_attack_area_body_exited(_body):
	player_near = false


func _on_notice_area_body_entered(_body):
	active = true


func _on_notice_area_body_exited(_body):
	active = false
