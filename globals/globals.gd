extends Node

signal stat_change


var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()


var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
		

var player_vulnerable: bool = true

# getter and setter
var health = 60:
	set(value):
		# player picks up a health item
		if value > health:
			health = min(value, 100) # limit the max health to 100
		else:
			# when player get hits
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				
		stat_change.emit()


# create a timer for player hit/damage similar to the node timer
func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable  = true


var player_pos: Vector2
