extends Node2D


var Store = []
var Total_Mass=0
func _ready():
	pass

func _physics_process(delta):
	StoreManage()

func StoreManage():
	Store.clear()
	Store.resize(WorldVar.MaxID+1)
	for i in get_children():
		
		if i.is_in_group("Store"):
			for j in i.Bag:
				if Store[j]==null:
					Store[j]=1
				else:
					Store[j]+=1
