extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var hit_timer = $HitTimer
@onready var explosion = $Explosion
@onready var animation_player = $AnimationPlayer

var active: bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1
var vulnerable: bool = true
var health: int  = 50


func _ready():
	explosion.hide()
	sprite_2d.show()


func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			animation_player.play("explosion")


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		hit_timer.start()
		print("drone got damage")
		sprite_2d.material.set_shader_parameter('progress', 1)
	if health <= 0:
		animation_player.play("explosion")

# used in animation
func stop_movement():
	speed_multiplier = 0


func _on_notice_area_body_entered(_body):
	active = true
	# speed up via tween when player enters the area
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable = true
	sprite_2d.material.set_shader_parameter('progress', 0)


