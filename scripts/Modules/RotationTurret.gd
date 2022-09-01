extends "res://scripts/BasicModule.gd"



export(PackedScene) var Bullet_Scene			#子弹实例
export var CD=0.0							#发射间隔 s
export var Firing_Range=0.0					#自动开火范围
var CDNow=0.0								#现在经过了多久cd
var Is_Ready=false

func _ready():
	add_to_group("RotationTurret")
	add_to_group("Weapon1")
	
func _physics_process(delta):
	if CDNow>0:
		CDNow-=delta
	if get_parent().name!="MousePoint":
		if CDNow<=0 and get_parent().Store[Bullet_Scene.instance().ID]!=null and get_parent().Store[Bullet_Scene.instance().ID]>0:
			CDNow=0
	
	Rotate(delta)


func Shoot():

	SignalBus.emit_signal("Shoot",Bullet_Scene.instance(),get_node("TurretBody/Muzzle").global_position,get_parent().get_parent().rotation+get_node("TurretBody").rotation,get_parent().get_parent())


func Rotate(delta):


	get_node("TurretBody").look_at(get_global_mouse_position())
