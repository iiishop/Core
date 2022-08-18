extends Sprite

onready var offset_ = 3
var is_changed = false

func inside():
	return get_rect().has_point(get_local_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if inside():
			get_tree().change_scene("res://scenes/World.tscn")
	elif event is InputEventMouseMotion:
		if inside():
			if not is_changed:
				is_changed = true
				position.y += offset_
		else:
			if is_changed:
				is_changed = false
				position.y -= offset_
