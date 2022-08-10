extends CollisionShape2D

export var LinkCollision:NodePath
#此辅助模块供给于子弹和导弹等需要物理碰撞效果的碰撞器使用，置于rigidbody2d一级子菜单
var Target=null


func _ready():
	get_node(LinkCollision).disabled=true
	global_position=get_node(LinkCollision).global_position
	



func _on_CheckArea_body_entered(body):
	if Target==null:
		Target=body


func _on_CheckArea_body_exited(body):
	if body==Target:
		Target=null
