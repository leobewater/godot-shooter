extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var hit_timer = $HitTimer
@onready var explosion = $Explosion
@onready var animation_player = $AnimationPlayer

var active: bool = false
var speed: int = 400

var vulnerable: bool = true
var health: int  = 50

func _ready():
	explosion.hide()
	sprite_2d.show()


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
		animation_player.play("explosion")


func _on_notice_area_body_entered(_body):
	active = true


func _on_hit_timer_timeout():
	vulnerable = true
