extends Node2D


func _ready():
	SignalBus.connect("Shoot",self,"_on_Shoot")
	SignalBus.connect("MissileShoot",self,"_on_MissileShoot")
	get_tree().debug_collisions_hint=true
	
func _on_Shoot(Bullet,Position,Rotation,i):

	add_child(Bullet)
	var Mass=i.get_node("ModuleManager").Total_Mass
	var V=i.linear_velocity
	Bullet.position=Position
	Bullet.rotate(Rotation)
	Bullet.set_axis_velocity((get_global_mouse_position()-Position).normalized()*Bullet.Speed+V)
	Bullet.Camp=i.Camp
	Bullet.GalaxyNow=i.GalaxyNow
	#为Core添加储存功能，储存器以质量来限定上限
	#添加储存器模块
	#发射物体后自上而下从拥有储存功能的模块减少相应质量
	#只有主角船为Core，为模块化船只，其他船都为自定造型
	
	#此处功能待添加（添加一个信号用以重新计算船只质量、质心位置、推进器相对位置、推力等）
	
	i.set_axis_velocity((V*Mass-Bullet.linear_velocity*Bullet.Mass)/i.get_node("ModuleManager").Total_Mass)
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
