extends StaticBody2D

# custom signal so it can communicate with other scenes (level)
signal player_entered_gate(body)

func _on_area_2d_body_entered(body):
	# emit/dispatch the custom signal
	player_entered_gate.emit(body)
