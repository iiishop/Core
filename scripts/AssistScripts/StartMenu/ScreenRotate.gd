extends Sprite

onready var angular_speed = PI / 128

func _process(delta):
	rotation += angular_speed * delta
