extends Area2D

export var LinkCollision:NodePath
#此辅助模块供给于子弹和导弹等需要物理碰撞效果的碰撞器使用，置于rigidbody2d一级子菜单
var Target=null


func _ready():
	get_node(LinkCollision).disabled=true



func _on_CheckArea_body_entered(body):
	if Target==null and body.Camp!=get_parent().Camp:
		if get_parent().Camp==-1:
			if get_node("/root/World/GalaxyManager").GalaxyMap[get_parent().GalaxyNow].FavorabilityMap[body.Camp]<0:
				Target=body
				get_node(LinkCollision).set_deferred("disabled",false)
		else:
			if get_node("/root/World/CampManager").CampMap[get_parent().Camp].FavorabilityMap[body.Camp]<0:
				Target=body
				get_node(LinkCollision).set_deferred("disabled",false)


func _on_CheckArea_body_exited(body):
	if body==Target:
		Target=null
		if get_node(LinkCollision)!=null:
			get_node(LinkCollision).set_deferred("disabled",true)
