extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

@onready var gpu_particles_2d = $GPUParticles2D

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):
	# Go to Project and create an input map first
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# move_and_slide auto uses velocity which auto uses delta
	velocity = direction * speed
	move_and_slide()
	
	# rotate player by facing the mouse pointer
	look_at(get_global_mouse_position())
	
	# calculate the direction of the mouse pointer
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		
		# show laser particle
		gpu_particles_2d.emitting = true
		
		# randomly select a marker 2D for the laser starting position
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		#print(selected_laser)
		
		# disable laser until timer is done
		can_laser = false
		
		# activate the timer and only allows player to shoot once with the defined wait time
		$Timer.start()
		
		# emit signal and emit the global position we selected
		laser.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeReloadTimer.start()
		# emit signal and marker 0 global position
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)


# when timer is finished
func _on_timer_timeout():
	can_laser = true
	
	
func _on_grenade_reload_timer_timeout():
	can_grenade = true
