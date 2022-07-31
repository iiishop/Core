extends Sprite


func _physics_process(delta):
	if get_parent().linear_velocity.x >0.1 or get_parent().linear_velocity.x <-0.1 or get_parent().linear_velocity.y >0.1 or get_parent().linear_velocity.y <-0.1:
		visible=true
		if get_parent().linear_velocity.y<0:
			rotation=asin(get_parent().linear_velocity.normalized().x)-get_parent().rotation
		else:
			rotation=-asin(get_parent().linear_velocity.normalized().x)-PI-get_parent().rotation
		
	else:
		visible=false
