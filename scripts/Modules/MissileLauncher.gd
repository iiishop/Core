extends "res://scripts/BasicModule.gd"

export(PackedScene) var Missile
export var CD=0.0
export var Firing_Range=0.0
var CDNow=0.0
var ML
var T
var Is_Ready=true

func _ready():
	add_to_group("MissileLauncher")
	add_to_group("Weapon1")
	
	ML=get_node("MissilePlatform/MissileLoad")
	ML.position=get_node("MissilePlatform/MissilePosition").position
	T=get_node("MissilePlatform/MissileLoader").position-get_node("MissilePlatform/MissilePosition").position
	T=T/CD

func _physics_process(delta):
	if CDNow>0 and get_parent().Store[Missile.instance().ID]!=null and get_parent().Store[Missile.instance().ID]>0:
		CDNow-=delta
		ML.position-=T*delta
		
	else:
		CDNow=0
	if !is_in_group("Auto"):
		get_node("MissilePlatform").look_at(get_global_mouse_position())

func Shoot():
	if get_parent().name!="MousePoint":
		if get_parent().Store[Missile.instance().ID]!=null and get_parent().Store[Missile.instance().ID]>0 and !Is_Ready:
			Is_Ready=true
		elif get_parent().Store[Missile.instance().ID]==null or get_parent().Store[Missile.instance().ID]<=0 and Is_Ready:
			ML.position=get_node("MissilePlatform/MissileLoader").position
			Is_Ready=false

	if get_parent().Store[Missile.instance().ID]!=null and get_parent().Store[Missile.instance().ID]>0:
		for i in get_parent().get_children():
			if i.is_in_group("Store"):
				if i.Remove(Missile.instance().ID):
					get_parent().StoreManage()
					break
		T=(get_node("MissilePlatform/MissileLoader").position-get_node("MissilePlatform/MissilePosition").position)/CDNow
		SignalBus.emit_signal("MissileShoot",Missile.instance(),get_node("MissilePlatform/MissilePosition").global_position,get_node("MissilePlatform").rotation+get_parent().get_parent().rotation,get_parent().get_parent())
		ML.position=get_node("MissilePlatform/MissileLoader").position	
	
