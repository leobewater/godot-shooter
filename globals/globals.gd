extends Node

signal health_change

var laser_amount = 20
var grenade_amount = 5

# getter and setter
var health = 60:
	get:
		return health
	set(value):
		health = value
		health_change.emit()
