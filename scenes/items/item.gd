extends Area2D

@onready var sprite_2d = $Sprite2D

var rotation_speed: int = 4
# give laser more chances
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options.pick_random()

var direction: Vector2
var distance: int = randi_range(150, 250)


func _ready():
	#print(type)
	if type == 'laser':
		sprite_2d.modulate = Color(0.1, 0.2, 0.8)
	elif type == 'grenade':
		sprite_2d.modulate = Color(0.8, 0.2, 0.1)
	elif type == 'health':
		sprite_2d.modulate = Color(0.1, 0.8, 0.1)
	
	# tween move and scale item
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, 'position', target_pos, 0.5)
	tween.tween_property(self, 'scale', Vector2(1,1), 0.3).from(Vector2(0,0)) # set start value


func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	# collides with player
	if type == 'laser':
		Globals.laser_amount += 5
	elif type == 'grenade':
		Globals.grenade_amount += 1
	elif type == 'health':
		Globals.health += 10
		
	#queue_free()
