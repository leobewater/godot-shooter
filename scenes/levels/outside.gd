extends LevelParent

#var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_player_entered_gate(body):
	print("Player has entered gate: ", body)

	# stop player from moving after entering the gate
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	#get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
	#get_tree().change_scene_to_packed(inside_level_scene)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


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
