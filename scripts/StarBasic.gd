extends RigidBody2D

export var Speed=0.0
onready var N = get_node("Sprite")
var Max
var rd=RandomNumberGenerator.new()



func _ready():
#	linear_velocity=Vector2.RIGHT*Speed
	add_central_force(Vector2.RIGHT*Speed)
	Max= N.hframes*N.vframes


func _on_Timer_timeout():
	if N.frame<Max-1:
		N.frame+=1
	else:
		N.frame=0
