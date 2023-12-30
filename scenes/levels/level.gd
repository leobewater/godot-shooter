extends Node2D

@onready var camera_2d = $Player/Camera2D

# preload laser scene
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	print("Player has entered gate")
	print(body)


func _on_player_laser(pos, direction):
	# create instance of laser scene
	var laser = laser_scene.instantiate() as Area2D
	
	# update laser position and direction
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
	# add laser instance to a Node2D
	$Projectiles.add_child(laser)

func _on_player_grenade(pos, direction):
	# create instance of grenade scene and as will help with intellisense
	var grenade = grenade_scene.instantiate() as RigidBody2D
	
	# update grenade position
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	
	# add grenade instance to a Node2D
	$Projectiles.add_child(grenade)


# when player enters the house
func _on_house_player_entered():
	print("Player has entered house in level")
	# camera zooom in with tween
	var tween = get_tree().create_tween()
	tween.tween_property(camera_2d, 'zoom', Vector2(1,1), 1)
