extends Area2D

@onready var sprite_2d = $Sprite2D

var rotation_speed: int = 4
# give laser more chances
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options.pick_random()


func _ready():
	#print(type)
	if type == 'laser':
		sprite_2d.modulate = Color(0.1, 0.2, 0.8)
	elif type == 'grenade':
		sprite_2d.modulate = Color(0.8, 0.2, 0.1)
	elif type == 'health':
		sprite_2d.modulate = Color(0.1, 0.8, 0.1)
		
		
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	# collides with player
	body.add_item(type)
	queue_free()