extends Node2D

var rd=RandomNumberGenerator.new()
var GalaxyMap=[]
var Time
func _ready():
	for i in range(200):
		GalaxyMap.append(Galaxy.new())
		GalaxyMap[i].ID=i
		InitPos(i)
		var t=load("res://scenes/Star.tscn").instance()
		
		get_parent().get_node("GUI/Galaxy/Map/Map").add_child(t)
		t.position=GalaxyMap[i].Pos

func _physics_process(delta):
	if Time!=WorldVar.WorldTime:
		Time=WorldVar.WorldTime
		
		for i in GalaxyMap:
			i.Mining()


class Cargo:
	var ID					#商店货物的物品ID
	var Price				#商店货物的本地价格

class Building:
	var ID
	var Pos

class Task:
	var ID
	var Kind				#任务种类
	var Need=[]				#任务需要上交的
	var Give=[]				#任务给予的

class Galaxy:
	var rd=RandomNumberGenerator.new()
	
	var ID					#唯一指定ID
	var Pos:Vector2			#星系在星图中的位置
	var Population			#星系的总人口
	var Resources=[]			#水金铁硅   指的是星系中的各类资源行星数量
	var Shop=[]				#星系商店中售卖的物品
	var Patrol_Ship=[]
	var War_Ship=[]
	var Cargo_Ship=[]
	var Buildings=[]
	var Task=[]				#星系发布的任务
	var Store=[]				#全星系的仓库
	var FavorabilityMap=[]	#此星系对阵营的好感度
	
	func _init():
		rd.randomize()
		Resources.resize(4)
		Store.resize(5000)
		for i in range(5000):
			Store[i]=0
		for i in range(4):
			Resources[i]=rd.randi_range(10,500)
	
	func Mining():
		for i in range(4):
			Store[i+1]+=Resources[i]











func InitPos(ID):			#初始化星系在星图中的位置
	rd.randomize()
	GalaxyMap[ID].Pos=Vector2(rd.randf_range(0,500),rd.randf_range(0,500))
	for i in range(ID):
		if (GalaxyMap[ID].Pos-GalaxyMap[i].Pos).length()<10:
			InitPos(ID)
			return
	return
