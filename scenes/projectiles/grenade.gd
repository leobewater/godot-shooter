extends RigidBody2D

@onready var animation_player = $AnimationPlayer

const speed = 750


func explode():
	animation_player.play("explosion")
