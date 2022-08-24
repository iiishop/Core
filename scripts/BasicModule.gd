extends Node2D



#所有模块必备的基础类
export var ID=0
export var MaxHP=1						#模块血量上限
var HP=0									#模块当前血量
export var Mass=0						#模块重量
export var Max_Power=0					#模块所需功率
export var Is_Working=true				#模块是否被启用
export var Can_Build_Up=false			#模块上方是否可以链接新模块
export var Can_Build_Down=false			#模块下方是否可以链接新模块
export var Can_Build_Left=false			#模块左方是否可以链接新模块
export var Can_Build_Right=false			#模块右方是否可以链接新模块
export var Length=1						#模块高度
export var Width=1						#模块宽度
export var Type=3						#模块类别 0船体 1武器 2推进器 3其他
var t									#模块的碰撞箱


func _ready():
	HP=MaxHP
	if HP>0:
		Is_Working=true

func _physics_process(delta):
	if Is_Working:
		if HP<=0:
			Is_Working=false
			ModuleDeath()

func ModuleDeath():
	pass

func Start():
	pass

func Changed():
	pass

func Col():
	if self.name!="Core" and Length!=0:
		t=CollisionShape2D.new()
		t.name=self.name+"C"
		t.add_to_group("Collision")
		t.shape=RectangleShape2D.new()
		t.shape.extents=Vector2(Width*8,Length*8)
		get_parent().get_parent().call_deferred("add_child",t)


