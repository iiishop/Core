extends Node2D


var Is_Core_in=false


func _on_Area2D_body_entered(body):
	if body.name=="Core":
		get_node("Label").visible=true
		Is_Core_in=true


func _on_Area2D_body_exited(body):
	if body.name=="Core":
		get_node("Label").visible=false
		Is_Core_in=false


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_E and Is_Core_in:
			get_parent().get_parent().get_node("CanvasLayer/ModulesList").visible=true
			get_parent().get_parent().get_node("CanvasLayer/Control").visible=true
			get_parent().get_parent().get_node("CanvasLayer/PlayerInterface").visible=false
			get_node("Label").visible=false
			get_tree().paused=true
			get_parent().get_parent().get_node("Core").rotation=0
			get_parent().get_parent().get_node("BackGroundManager/BackGroundNow").texture=load("res://asset/new folder/Spaceport Background.png")
			WorldVar.Is_In_Creating_Mode=true
