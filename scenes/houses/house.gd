extends Area2D


signal player_entered
signal player_exited


func _on_body_entered(body):
	print("Player has entered:", body)
	player_entered.emit()


func _on_body_exited(body):
	print("Player left:", body)
	player_exited.emit()
