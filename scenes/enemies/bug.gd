extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_timer = $Node/AttackTimer
@onready var hit_timer = $Node/HitTimer
@onready var hit_particles = $Particles/HitParticles

var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_near: bool = false
var health = 20


func hit():
	if vulnerable:
		vulnerable = false
		hit_timer.start()
		print("Bug was hit")
		health -= 10
		animated_sprite_2d.material.set_shader_parameter("progress", 0.8)
		hit_particles.emitting = true
		
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()


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


func _on_animated_sprite_2d_animation_finished():
	# walk animation is loop and never triggered finished
	# only attack animation finished
	if player_near:
		Globals.health -= 10
		attack_timer.start()
		

func _on_hit_timer_timeout():
	vulnerable = true
	animated_sprite_2d.material.set_shader_parameter("progress", 0.0)


func _on_attack_timer_timeout():
	animated_sprite_2d.play("attack")
