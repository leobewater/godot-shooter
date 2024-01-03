extends CharacterBody2D

@onready var laser_spawn_positions = $LaserSpawnPositions
@onready var laser_timer = $LaserTimer
@onready var marker_2d = $LaserSpawnPositions/Marker2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true


signal laser(pos, direction)

func hit():
	print("scout was hit")
	
	
func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			# alternate the scout's gun
			var marker_node = laser_spawn_positions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			laser_timer.start()


# detect player enter scout's attack area
func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
