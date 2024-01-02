extends Node2D
class_name LevelParent

@onready var camera_2d = $Player/Camera2D
@onready var player = $Player
@onready var ui = $UI
@onready var items = $Items

# preload laser scene
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")



func _ready():
	# get all item_containers named "Container" group from level and add listeners
	for container in get_tree().get_nodes_in_group("Container"):
		#print(container)
		# set up signal listeners on item_container
		container.connect("open", _on_container_opened)
	

func _on_container_opened(pos, direction):
	print("container opened", pos, direction)
	# spawn item
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	items.call_deferred("add_child", item)
	
	
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




