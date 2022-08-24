extends "res://scripts/BasicModule.gd"

var Bag=[]
export var Max_Weight=0.0		#支持的最大重量
var Now_Weight=0.0

func _ready():
	add_to_group("Store")


func Add(n):
	if Now_Weight+ConfigHelper.Items.by_id(n).weight<=Max_Weight:
		Bag.append(n)
		get_parent().Total_Mass+=ConfigHelper.Items.by_id(n).weight
		Now_Weight+=ConfigHelper.Items.by_id(n).weight
		return true
	else:
		return false

func Remove(n):
	if Bag.has(n) and Is_Working:
		Now_Weight-=ConfigHelper.Items.by_id(n).weight
		get_parent().Total_Mass-=ConfigHelper.Items.by_id(n).weight
		Bag.erase(n)
		return true
	else:
		return false

func Count(n):
	var count=0
	for i in Bag:
		if i==n:
			count+=1
	return count
