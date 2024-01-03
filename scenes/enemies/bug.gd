extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_near: bool = false


func _process(delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_pos)


func _on_attack_area_body_entered(_body):
	player_near = true
	animated_sprite_2d.play("attack")


func _on_attack_area_body_exited(_body):
	player_near = false
	animated_sprite_2d.stop()


func _on_notice_area_body_entered(_body):
	active = true
	animated_sprite_2d.play("walk")


func _on_notice_area_body_exited(_body):
	active = false
	animated_sprite_2d.stop()
