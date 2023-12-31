extends LevelParent


func _on_exit_gate_area_body_entered(body):
	print("Player has exited inside level: ", body)

	# stop player from moving after entering the gate
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	
