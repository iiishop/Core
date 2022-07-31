extends "res://scripts/BasicModule.gd"



export(PackedScene) var Bullet_Scene	#子弹实例
export var CD=0.0							#发射间隔 s
var CDNow=0.0							#现在经过了多久cd
var Is_Ready=false

func _ready():
	add_to_group("RotationTurret")
	
func _physics_process(delta):
	if CDNow>0:
		CDNow-=delta
	else:
		CDNow=0
	
	Rotate(delta)


func Shoot():

	SignalBus.emit_signal("Shoot",Bullet_Scene.instance(),get_node("TurretBody/Muzzle").global_position)


func Rotate(delta):


	get_node("TurretBody").look_at(get_global_mouse_position())
