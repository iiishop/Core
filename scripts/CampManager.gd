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
		for j in range(CampMap.size()):
			i.FavorabilityMap.append(0)
		print(i.Name)



class Camp:

	var rd=RandomNumberGenerator.new()
	
	var ID
	var Name=""
	var FavorabilityMap=[]
	var Friend=[]
	var Hostile=[]
	func _init():
		for i in range(5):
			rd.randomize()
			Name+=char(65+rd.randi_range(0,26))
