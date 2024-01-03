extends PathFollow2D

@onready var turret = $Turret

@onready var ray_cast_1 = $Turret/RayCast2D
@onready var line1 = $Turret/RayCast2D/Line2D

@onready var ray_cast_2 = $Turret/RayCast2D2
@onready var line2 = $Turret/RayCast2D2/Line2D


var player_near: bool = false


func _ready():
	line2.add_point(ray_cast_2.target_position)
	

func _process(delta):
	progress_ratio += 0.01 * delta
	if player_near:
		turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(_body):
	player_near = true


func _on_notice_area_body_exited(_body):
	player_near = false
