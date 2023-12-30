extends RigidBody2D

@onready var animation_player = $AnimationPlayer

const speed = 750


# this being called from the blinking animation
func explode():
	animation_player.play("explosion")
