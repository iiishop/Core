extends Node2D

 
func Create():								#模块碰撞箱相关
	for i in get_parent().get_children():
		if i.is_in_group("Collision"):
			i.position=get_parent().get_node("ModuleManager/"+i.name.trim_suffix("C")).position+position
