extends "res://scripts/BasicModule.gd"

export var Conversition_Rate=1.0			#每0.1份水可以转换为多少份的氢气
export var CD=1.0
var CDNow=0.0


func _ready():
	add_to_group("HydManufacture")


func _physics_process(delta):
	if CDNow>0:
		if CDNow-delta>=0:
			CDNow-=delta
		else:
			CDNow=0

