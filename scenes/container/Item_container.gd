extends StaticBody2D

class_name ItemContainer

# run this after the ready() method which already applied the rotation set in the trees
# so when we spawn the item, it will follow the parent item's rotation
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

var opened: bool = false

signal open(pos, direction)
