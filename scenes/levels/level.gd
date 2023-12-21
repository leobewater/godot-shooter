extends Node2D

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
