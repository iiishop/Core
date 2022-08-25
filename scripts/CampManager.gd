extends Node2D


var CampMap=[]
var rd=RandomNumberGenerator.new()
onready var GalaxyManager=get_parent().get_node("GalaxyManager")
func _ready():
	CampMap.append(Camp.new())
	CampMap[0].ID=0
	CampMap[0].Name="海盗"
	rd.randomize()
	CampMap[0].Galaxy.append(rd.randi_range(0,199))
	GalaxyManager.GalaxyMap[CampMap[0].Galaxy[0]].Camp=0
	CampMap[0].FavorabilityMap.append(100)
	for i in GalaxyManager.GalaxyMap:
		i.FavorabilityMap.append(-10)
	GalaxyManager.GalaxyMap[CampMap[0].Galaxy[0]].FavorabilityMap[0]=100
	
	
	for i in range(6):
		rd.randomize()
		while CampAdd(rd.randi_range(0,199)):
			break
	CampMap[1].Name="玩家"



func CampAdd(GalaxyID):						#创建一个新的阵营，提供阵营首都的星系ID
	if GalaxyManager.GalaxyMap[GalaxyID].Camp==-1:
		CampMap.append(Camp.new())
		CampMap[CampMap.size()-1].ID=CampMap.size()-1
		CampMap[CampMap.size()-1].Galaxy.append(GalaxyID)
		GalaxyManager.GalaxyMap[GalaxyID].Camp=CampMap.size()-1
		for i in CampMap:
			if i.ID==0:
				i.FavorabilityMap.append(-10)
			elif i.ID==CampMap.size()-1:
				for j in CampMap:
					if j.ID==0:
						i.FavorabilityMap.append(-10)
					elif j.ID==i.ID:
						i.FavorabilityMap.append(100)
					else:
						i.FavorabilityMap.append(0)
			else:
				i.FavorabilityMap.append(0)
		for i in GalaxyManager.GalaxyMap:
			i.FavorabilityMap.append(0)
		return true
	else:
		return false

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
