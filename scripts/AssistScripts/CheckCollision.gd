extends CollisionShape2D

export var LinkCollision:NodePath
#此辅助模块置于船只一级目录下，父节点为Rigidbody2d类型的船只根结点
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
