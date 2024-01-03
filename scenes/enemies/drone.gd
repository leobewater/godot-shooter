extends CharacterBody2D

var active: bool = false
var speed: int = 400

@onready var hit_timer = $HitTimer

var vulnerable: bool = true
var health: int  = 50

func _process(_delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		hit_timer.start()
		print("drone got damage")
	if health <= 0:
		queue_free()

func _on_notice_area_body_entered(_body):
	active = true


func _on_hit_timer_timeout():
	vulnerable = true
