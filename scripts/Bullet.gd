extends RigidBody2D

export var ID=0
export var Speed=100			#子弹射速
export var CD=5.0			#子弹存在时长
export var Hurt=0.0			#子弹伤害
export var Mass=10			#单颗子弹质量
var Camp=-1
var GalaxyNow

func _physics_process(delta):
	if CD>0:
		CD-=delta
	else:
		free()

