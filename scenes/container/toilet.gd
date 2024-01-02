extends ItemContainer

@onready var lid_sprite = $LidSprite
@onready var spawn_positions = $SpawnPositions
@onready var marker_2d = $SpawnPositions/Marker2D

func hit():
	if not opened:
		# when getting shot the lid disappear
		lid_sprite.hide()
		
		var pos = marker_2d.global_position
		open.emit(pos, current_direction)
		opened = true
