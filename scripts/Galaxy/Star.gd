extends Node2D


var ID=0



func _on_Galaxy_mouse_entered():
	get_node("GalaxyInfo").visible=true


func _on_Galaxy_mouse_exited():
	get_node("GalaxyInfo").visible=false
