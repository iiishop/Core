extends TextureButton

onready var offset_ = 3
var is_changed = false

func _process(delta):
	if is_hovered():
		if not is_changed:
			is_changed = true
			rect_position.y += offset_
	else:
		if is_changed:
			is_changed = false
			rect_position.y -= offset_

func _pressed():
	get_tree().quit()
