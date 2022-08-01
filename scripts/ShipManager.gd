extends Node2D


var Store=[]
var MaxID=1
func _ready():
	InitMaxID()
	Store.resize(MaxID+1)
	print(Store)










































































func InitMaxID():
	while ConfigHelper.Items.has_id(MaxID):
		MaxID+=1
	MaxID-=1
