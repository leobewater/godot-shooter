extends PathFollow2D

@onready var turret = $Turret


var player_near: bool = false


func _process(delta):
	progress_ratio += 0.01 * delta
	if player_near:
		turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(body):
	player_near = true


func _on_notice_area_body_exited(body):
	player_near = false
