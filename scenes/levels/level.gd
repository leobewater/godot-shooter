extends Node2D
class_name LevelParent

@onready var camera_2d = $Player/Camera2D
@onready var player = $Player
@onready var ui = $UI


# preload laser scene
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")


func _ready():
	print("level")
	print(Globals.laser_amount)
	
	
func _on_player_laser(pos, direction):
	# create instance of laser scene
	var laser = laser_scene.instantiate() as Area2D
	
	# update laser position and direction
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
	# add laser instance to a Node2D
	$Projectiles.add_child(laser)
	
	# update UI label
	ui.update_laser_text()


func _on_player_grenade(pos, direction):
	# create instance of grenade scene and as will help with intellisense
	var grenade = grenade_scene.instantiate() as RigidBody2D
	
	# update grenade position
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	
	# add grenade instance to a Node2D
	$Projectiles.add_child(grenade)

	# update UI label
	ui.update_grenade_text()


# when player enters the house
func _on_house_player_entered():
	print("Player has entered house in level")
	# by default multiple tween_property play in sequences, use set_parallel to run them all at once
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	# changing player's alpha value with a initial value
	#tween.tween_property(player, 'modulate:a', 0, 2).from(0.5)
	
	# camera zooom in with tween with custom transition
	tween.tween_property(camera_2d, 'zoom', Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)


# when player exits the house
func _on_house_player_exited():
	print("Player has exited the house in level")
	# camera zooom out with tween
	var tween = get_tree().create_tween()
	tween.tween_property(camera_2d, 'zoom', Vector2(0.6, 0.6), 1)
