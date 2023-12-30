extends Area2D


@onready var self_destruct_timer = $SelfDestructTimer


@export var speed: int = 1000


var direction: Vector2 = Vector2.UP


func _ready():
	self_destruct_timer.start()

func _process(delta):
	position += direction * speed * delta


# when laser collides
func _on_body_entered(body):
	print("laser collision:", body)
	# check a method or property is inside the body node
	if "hit" in body:
		body.hit()
	#if "is_enemy" in body:
		#print("it's an enemy")
	queue_free()


# remove laser itself after 2 seconds
func _on_self_destruct_timer_timeout():
	queue_free()
