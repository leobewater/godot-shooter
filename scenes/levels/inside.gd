extends LevelParent

#var outside_level_scene: PackedScene = preload("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(body):
	print("Player has exited inside level: ", body)

	# stop player from moving after entering the gate
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	#get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
	#get_tree().change_scene_to_packed(outside_level_scene)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
