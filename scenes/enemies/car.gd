extends PathFollow2D

@onready var turret = $Turret
#@onready var ray_cast_1 = $Turret/RayCast2D
#@onready var line1 = $Turret/RayCast2D/Line2D
#
#@onready var ray_cast_2 = $Turret/RayCast2D2
#@onready var line2 = $Turret/RayCast2D2/Line2D
@onready var animation_player = $AnimationPlayer
@onready var gun_fire_1 = $Turret/GunFire1
@onready var gun_fire_2 = $Turret/GunFire2

var player_near: bool = false


# being called in animation
func fire():
	Globals.health -= 20
	gun_fire_1.modulate.a = 1
	gun_fire_2.modulate.a = 1
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire_1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire_2, "modulate:a", 0, randf_range(0.1, 0.5))
	
	
func _ready():
	# use code to generate line for line2
	#line2.add_point(ray_cast_2.target_position)
	pass


func _process(delta):
	progress_ratio += 0.02 * delta
	if player_near:
		turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(_body):
	player_near = true
	# use animation
	animation_player.play("laser_load")


func _on_notice_area_body_exited(_body):
	player_near = false
	animation_player.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire_1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire_2, "width", 0, randf_range(0.1, 0.5))
	await tween.finished
	animation_player.stop()
