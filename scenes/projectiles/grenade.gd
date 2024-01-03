extends RigidBody2D

@onready var animation_player = $AnimationPlayer

const speed = 750
var explosion_active: bool = false
var explosion_radius: int = 400


# this being called from the blinking animation
func explode():
	animation_player.play("explosion")
	explosion_active = true


func _process(_delta):
	if explosion_active:
		# hit all targets within the radius when explode
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()
