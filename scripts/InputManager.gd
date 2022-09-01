extends RigidBody2D

var Camp=1								#所属阵营
var GalaxyNow=0
var Is_Ship=true
var HP=100
var MaxHP=100

var IsBraking=false
var IsRotateU=false
var IsRotateD=false
var IsRotateL=false
var IsRotateR=false

var OriginForceVector:Vector2

func _ready():
	mass=get_node("ModuleManager").Total_Mass
	
	for i in get_children():
		
		i.position-=get_node("ModuleManager").Center_Mass
	position+=get_node("ModuleManager").Center_Mass




func _physics_process(delta):

	if (Input.is_action_just_pressed("Clockwise_Rotation") or Input.is_action_just_released("Anticlockwise_Rotation")) and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		add_torque(get_node("ModuleManager").Moment*get_node("ModuleManager").PowerPercent) 
	if (Input.is_action_just_released("Clockwise_Rotation") or Input.is_action_just_pressed("Anticlockwise_Rotation")) and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		add_torque(-get_node("ModuleManager").Moment*get_node("ModuleManager").PowerPercent)


	if Input.is_action_pressed("up")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		MoveUp()

	if Input.is_action_just_released("up")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		OriginForceVector.y=0
		applied_torque=0
		IsRotateU=false
		Move()
		CloseParticles("Up")

	if Input.is_action_pressed("down")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		MoveDown()

	if Input.is_action_just_released("down")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		OriginForceVector.y=0
		applied_torque=0
		IsRotateD=false
		Move()
		CloseParticles("Down")

	if Input.is_action_pressed("left")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		MoveLeft()

	if Input.is_action_just_released("left")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		OriginForceVector.x=0
		applied_torque=0
		IsRotateL=false
		Move()
		CloseParticles("Left")

	if Input.is_action_pressed("right")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		MoveRight()
	if Input.is_action_just_released("right")and !IsBraking and !WorldVar.Is_In_Creating_Mode:
		OriginForceVector.x=0
		applied_torque=0
		IsRotateR=false
		Move()
		CloseParticles("Right")



	if Input.is_action_pressed("Shoot1") and !WorldVar.Is_In_Creating_Mode:
		for i in get_node("ModuleManager").get_children():
			if (i.is_in_group("RotationTurret") or i.is_in_group("Turret") or i.is_in_group("MissileLauncher") or i.is_in_group("ImmobileMissileLauncher")) and i.Is_Working:
				if i.CDNow<=0 and i.Is_Ready:
					i.CDNow=i.CD/get_node("ModuleManager").PowerPercent
					i.Shoot()



	if Input.is_action_pressed("Braking") and !WorldVar.Is_In_Creating_Mode:
		IsBraking=true
		var V=Vector2(linear_velocity.x*cos(rotation),linear_velocity.y*cos(rotation))
		
		
		if V.y==0 and pow(angular_velocity,get_node("ModuleManager").Moment_UP)>=0:
			CloseParticles("Up")
		if V.y==0 and pow(angular_velocity,get_node("ModuleManager").Moment_Down)>=0:
			CloseParticles("Down")
		if V.x==0 and pow(angular_velocity,get_node("ModuleManager").Moment_Left)>=0:
			CloseParticles("Left")
		if V.x==0 and pow(angular_velocity,get_node("ModuleManager").Moment_Right)>=0:
			CloseParticles("Right")
		
		if angular_velocity<-0.1:
			applied_torque=(get_node("ModuleManager").Moment)*get_node("ModuleManager").PowerPercent
			if get_node("ModuleManager").Moment_UP>0:
				MoveUp()
			if get_node("ModuleManager").Moment_Down>0:
				MoveDown()
			if get_node("ModuleManager").Moment_Left>0:
				MoveLeft()
			if get_node("ModuleManager").Moment_Right>0:
				MoveRight()
			
		if angular_velocity>0.1:
			applied_torque=(-get_node("ModuleManager").Moment)*get_node("ModuleManager").PowerPercent
			
			if get_node("ModuleManager").Moment_UP<0:
				MoveUp()
			if get_node("ModuleManager").Moment_Down<0:
				MoveDown()
			if get_node("ModuleManager").Moment_Left<0:
				MoveLeft()
			if get_node("ModuleManager").Moment_Right<0:
				MoveRight()
			
		if angular_velocity>=-0.1 and angular_velocity<=0.1:
			applied_torque=0
			angular_velocity=0
			IsRotateD=false
			IsRotateL=false
			IsRotateR=false
			IsRotateU=false


		if V!=Vector2(0,0):
			if V.length()<=1:
				linear_velocity=Vector2(0,0)
				V=Vector2(0,0)


			if V.x>0.001:
				MoveLeft()
			if V.x>=-0.0008 and V.x<=0.0012:
				applied_force.x=0
				IsRotateL=false
				IsRotateR=false
			if V.x<-0.001:
				MoveRight()


			if V.y>0.001:
				MoveUp()
			if V.y>=-0.0008 and V.y<=0.0012:
				applied_force.y=0
				IsRotateD=false
				IsRotateU=false
			if V.y<-0.001:
				MoveDown()


	if Input.is_action_just_released("Braking") and !WorldVar.Is_In_Creating_Mode:
		IsBraking=false
		applied_torque=0
		applied_force=Vector2.ZERO
		OriginForceVector=Vector2.ZERO
		CloseParticles("Left")
		CloseParticles("Right")
		CloseParticles("Up")
		CloseParticles("Down")

	#get_node("CoreManager").Create()



func Move():
	applied_force=OriginForceVector.rotated(rotation)


func OpenParticles(direct:String):
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group(direct): 
			i.get_node("Particles2D").emitting=true

func CloseParticles(direct:String):
	for i in get_node("ModuleManager").get_children():
		if i.is_in_group(direct): 
			i.get_node("Particles2D").emitting=false

func MoveUp():
	OriginForceVector.y=-get_node("ModuleManager").Force_UP
	if !IsRotateU:
		applied_torque+=get_node("ModuleManager").Moment_UP
		IsRotateU=true
	Move()
	OpenParticles("Up")

func MoveDown():
	OriginForceVector.y=get_node("ModuleManager").Force_Down
	if !IsRotateD:
		applied_torque+=get_node("ModuleManager").Moment_Down
		IsRotateD=true
	Move()
	OpenParticles("Down")

func MoveLeft():
	OriginForceVector.x=-get_node("ModuleManager").Force_Left
	if !IsRotateL:
		applied_torque+=get_node("ModuleManager").Moment_Left
		IsRotateL=true
	Move()
	OpenParticles("Left")

func MoveRight():
	OriginForceVector.x=get_node("ModuleManager").Force_Right
	if !IsRotateR:
		applied_torque+=get_node("ModuleManager").Moment_Right
		IsRotateR=true
	Move()
	OpenParticles("Right")





func _on_Button_button_up():
	mass=get_node("ModuleManager").Total_Mass
	position=get_node("ModuleManager").Center_Mass
	for i in get_children():
		i.position=-get_node("ModuleManager").Center_Mass
	get_node("CoreManager").Create()
	get_node("Camera2D").position=Vector2.ZERO
	get_node("ForArrows").position=Vector2.ZERO
	get_node("SPDArrows").position=Vector2.ZERO
