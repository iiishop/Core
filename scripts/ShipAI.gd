extends Node2D


var target=null
var Camp=-1



func _ready():
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group("ImmobileMissileLauncher") or i.is_in_group("Turret") or i.is_in_group("RotationTurret") or i.is_in_group("MissileLauncher"):
			i.add_to_group("Auto")

func _physics_process(delta):
	if target!=null:
		Attack()
enum Behavior{
	Attack,
	Idle,
	Patral
}

func Attack():
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group("ImmobileMissileLauncher") or i.is_in_group("Turret"):
			if abs(Vector2(1,0).rotated(rotation).angle_to(i.global_position.direction_to(target.global_position)))<=0.1:
				#print(get_node("Manager").Store)
				#print(i.Is_Ready)
				if i.CDNow<=0 and i.Is_Ready and i.global_position.distance_to(target.global_position)<=i.Firing_Range:
					i.CDNow=i.CD
					i.Shoot()
					get_node("ModuleManager").StoreManage()
		elif i.is_in_group("RotationTurret") or i.is_in_group("MissileLauncher"):
			i.look_at(target)
			if i.CDNow<=0 and i.Is_Ready and i.global_position.distance_to(target.global_position)<=i.Firing_Range:
				i.CDNow=i.CD
				i.Shoot()

func Idle():
	pass

func Patral():
	pass

func _on_AttackArea_body_entered(body):
	target=body
