extends "res://scripts/BasicModule.gd"



export(PackedScene) var Bullet_Scene		#子弹实例
export var CD=0.0						#发射间隔 s
export var Firing_Range=0.0				#自动发射的射程
var CDNow=0.0							#现在经过了多久cd
var Is_Ready=false

func _ready():
	add_to_group("Turret")
	
func _physics_process(delta):
	if CDNow>0:
		CDNow-=delta
	else:
		CDNow=0



func Shoot():

	SignalBus.emit_signal("Shoot",Bullet_Scene.instance(),get_node("Muzzle").global_position,get_parent().get_parent().rotation,get_parent().get_parent())

