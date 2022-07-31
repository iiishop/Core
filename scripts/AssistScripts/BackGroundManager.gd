extends Node2D

var BackgroundNow

func _ready():
	BackgroundNow=get_node("BackGroundNow").texture

#func _physics_process(delta):
#	global_position=get_node("../Core/Camera2D").get_camera_position()
