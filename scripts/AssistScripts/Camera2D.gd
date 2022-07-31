extends Camera2D
var pull = false
var mousePos
var currentPos
func _physics_process(delta):
	if current:
		if Input.is_action_just_released("ScrollUp"):
			if zoom.x >= 0.4 and zoom.y >= 0.4:
				get_parent().get_node("ForArrows").scale-=Vector2(0.2,0.2)
				get_parent().get_node("SPDArrows").scale-=Vector2(0.2,0.2)
				if WorldVar.Is_In_Creating_Mode:
					get_parent().get_parent().get_node("BackGroundManager/BackGroundNow").scale-=Vector2(0.2,0.2)
				zoom.x -= 0.2
				zoom.y -= 0.2
		if Input.is_action_just_released("ScrollDown"):
			if zoom.x <= 2 and zoom.y <= 2:
				get_parent().get_node("ForArrows").scale+=Vector2(0.2,0.2)
				get_parent().get_node("SPDArrows").scale+=Vector2(0.2,0.2)
				if WorldVar.Is_In_Creating_Mode:
					get_parent().get_parent().get_node("BackGroundManager/BackGroundNow").scale+=Vector2(0.2,0.2)
				zoom.x += 0.2
				zoom.y += 0.2
		if WorldVar.Is_In_Creating_Mode:
			if Input.is_action_just_pressed("MMB"):
				mousePos = get_global_mouse_position()
			if Input.is_action_pressed("MMB"):
				currentPos = get_global_mouse_position()
				offset.x -= currentPos.x-mousePos.x
				offset.y -= currentPos.y - mousePos.y
		if !WorldVar.Is_In_Creating_Mode:
			offset=Vector2.ZERO
