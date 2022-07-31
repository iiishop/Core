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
	var ID
	var Price

class Building:
	var ID
	var Pos

class Task:
	var ID
	var Kind
	var Need=[]
	var Give=[]

class Galaxy:
	var rd=RandomNumberGenerator.new()
	var ID
	var Pos:Vector2
	var Population
	var Resources=[]		#水金铁硅
	var Shop=[]
	var Patrol_Ship=[]
	var War_Ship=[]
	var Cargo_Ship=[]
	var Buildings=[]
	var Task=[]
	var Store=[]
	
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
	











func InitPos(ID):
	rd.randomize()
	GalaxyMap[ID].Pos=Vector2(rd.randf_range(0,500),rd.randf_range(0,500))
	for i in range(ID):
		if (GalaxyMap[ID].Pos-GalaxyMap[i].Pos).length()<10:
			InitPos(ID)
			return
	return
