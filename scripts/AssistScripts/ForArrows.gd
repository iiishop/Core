extends Sprite


func _physics_process(delta):
	if get_parent().applied_force.x >0.001 or get_parent().applied_force.x <-0.001 or get_parent().applied_force.y >0.001 or get_parent().applied_force.y <-0.001:
		visible=true
		if get_parent().applied_force.y<0:
			rotation=asin(get_parent().applied_force.normalized().x)-get_parent().rotation
		else:
			rotation=-asin(get_parent().applied_force.normalized().x)-PI-get_parent().rotation
		
	else:
		visible=false
