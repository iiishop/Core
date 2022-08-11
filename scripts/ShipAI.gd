extends RigidBody2D


var target=null
export var Camp=-1			#飞船所属的阵营 -1为无
var GalaxyNow=0		#飞船当前所载的星系的ID，和玩家相同时飞船可见
					#当飞船无阵营时，飞船不会进行跃迁操作，好感度列表为当前所处阵营的

export var MaxRotSpeed=0.0	#船只最大旋转速度
export var Force=0.0			#供给船只加速的力
export var Moment=0.0		#供给船只旋转的力矩
export var Distance=0.0		#船只距离目标船只的极限距离





func _ready():
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group("ImmobileMissileLauncher") or i.is_in_group("Turret") or i.is_in_group("RotationTurret") or i.is_in_group("MissileLauncher"):
			i.add_to_group("Auto")

func _physics_process(delta):
	if target!=null:			#test
		Attack()


enum Behavior{
	Attack,
	Idle,
	Patral
}


func Attack():
	Move(target.global_position)
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group("ImmobileMissileLauncher") or i.is_in_group("Turret"):
			if abs(Vector2(1,0).rotated(rotation).angle_to(i.global_position.direction_to(target.global_position)))<=0.1:
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



func Move(Pos:Vector2):			#向Pos运动，Pos必须为global_position
	linear_damp=0
	var angleT=(Vector2(1,0).rotated(rotation)).angle_to(Pos-global_position)
#	linear_velocity=Vector2(linear_velocity.length(),0).rotated(rotation)
	if angleT>0.1:
		if abs(angular_velocity)<=MaxRotSpeed:
			applied_torque=Moment
		else:
			applied_torque=0
		applied_force=Vector2.ZERO
	elif angleT<-0.1:
		if abs(angular_velocity)<=MaxRotSpeed:
			applied_torque=-Moment
		else:
			applied_torque=0
		applied_force=Vector2.ZERO
	else:
		look_at(Pos)
		applied_torque=0
		angular_velocity=0
		if (Pos-global_position).length()>=Distance+5:
			applied_force=Vector2(Force,0).rotated(rotation)
		elif (Pos-global_position).length()<=Distance-5:
			if abs(linear_velocity.length()-target.linear_velocity.length())>=2:
				linear_damp=1.5
			applied_force=-Vector2(Force,0).rotated(rotation)
		else:
			if abs(linear_velocity.length()-target.linear_velocity.length())>=2:
				linear_damp=1.3
			if abs(linear_velocity.length()-target.linear_velocity.length())<=1:
				applied_force=Vector2.ZERO


func _on_AttackArea_body_entered(body):
	if target==null and body!=self and body.Camp!=Camp:
		if Camp==-1:
			if get_node("/root/World/GalaxyManager").GalaxyMap[GalaxyNow].FavorabilityMap[body.Camp]<0:
				target=body
		else:
			if get_node("/root/World/CampManager").CampMap[Camp].FavorabilityMap[body.Camp]<0:
				target=body


func _on_AttackArea_body_exited(body):
	if target==body:
		target=null
