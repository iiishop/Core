extends CanvasLayer


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_M:
			get_node("Galaxy/Map").popup()
			get_tree().paused=true
		if event.scancode == KEY_B:
			get_node("Bag/Bag").popup()
			get_tree().paused=true


func _on_Map_popup_hide():
	get_tree().paused=false


func _on_Bag_popup_hide():
	get_tree().paused=false
