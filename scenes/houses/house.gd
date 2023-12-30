extends Area2D


signal player_entered


func _on_body_entered(body):
	print("Player has entered:", body)
	player_entered.emit()
