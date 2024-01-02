extends ItemContainer

@onready var lid_sprite = $LidSprite
@onready var spawn_positions = $SpawnPositions

func hit():
	#print("crate current_direction: ", current_direction)
	
	# when getting shot the lid disappear
	lid_sprite.hide()
	
	# create multiple items
	for i in range(5):
		# randomly pick a marker 2d for spawning starting position
		var pos = spawn_positions.get_children().pick_random().global_position
		open.emit(pos, current_direction)


