extends Node2D


var CampMap=[]
var rd=RandomNumberGenerator.new()
onready var GalaxyManager=get_parent().get_node("GalaxyManager")
func _ready():
	for i in range(7):
		CampMap.append(Camp.new())
		CampMap[i].ID=i
	CampMap[0].Name="玩家"
	CampMap[1].Name="海盗"
	for i in CampMap:
		if i.Name!="海盗":
			for j in range(7):
				i.FavorabilityMap.append(0)
			i.FavorabilityMap[1]=-10
			for j in get_parent().get_node("GalaxyManager").GalaxyMap:
				j.FavorabilityMap.append(0)
		else:
			for j in range(7):
				i.FavorabilityMap.append(-10)
			i.FavorabilityMap[1]=0
			for j in get_parent().get_node("GalaxyManager").GalaxyMap:
				j.FavorabilityMap.append(-10)

func CampAdd(GalaxyID):						#创建一个新的阵营，提供阵营首都的星系ID
	pass

func CampRemove(ID):							#删除一个阵营，提供阵营ID
	pass


class Camp:

	var rd=RandomNumberGenerator.new()
	
	var ID
	var Name=""
	var FavorabilityMap=[]					#与其他阵营的好感度
	var Friend=[]							#友好阵营
	var Hostile=[]							#敌对阵营
	var Galaxy=[]							#拥有的星系
	func _init():
		for i in range(5):
			rd.randomize()
			Name+=char(65+rd.randi_range(0,26))
