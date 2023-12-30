extends LevelParent


func _on_gate_player_entered_gate(body):
	print("Player has entered gate: ", body)

	# stop player from moving after entering the gate
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	
