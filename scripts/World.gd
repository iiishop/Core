extends Node2D


func _ready():
	SignalBus.connect("Shoot",self,"_on_Shoot")
	SignalBus.connect("MissileShoot",self,"_on_MissileShoot")
	get_tree().debug_collisions_hint=true
	
func _on_Shoot(Bullet,Position,Rotation,i):

	add_child(Bullet)
	var Mass=0.0
	
	if i.name=="Core":
		Mass=i.get_node("ModuleManager").Total_Mass
	var V=i.linear_velocity
	
	Bullet.position=Position
	Bullet.rotate(Rotation)
	Bullet.Camp=i.Camp
	Bullet.GalaxyNow=i.GalaxyNow
	
	Bullet.set_axis_velocity(Vector2.RIGHT.rotated(Rotation)*Bullet.Speed+V)
	i.set_axis_velocity((V*Mass-Bullet.linear_velocity*Bullet.Mass)/Mass)
	
	
	#实际上此处不应该直接为核心赋予新速度，应该改用反作用力的形式，作用在点上
	#游戏发射炮弹缺少炮管加速的过程，因此无法计算所需作用力
	#可以考虑添加加速时间，用以通过冲量来反推出力的大小
	
func _on_MissileShoot(Missile,Position,Rotation,i):
	add_child(Missile)
	Missile.position=Position
	Missile.rotate(Rotation)
	Missile.linear_velocity=i.linear_velocity+10*Vector2.RIGHT.rotated(Rotation)
	Missile.Camp=i.Camp
	Missile.GalaxyNow=i.GalaxyNow
	Missile.Shoot()
