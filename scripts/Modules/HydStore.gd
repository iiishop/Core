extends "res://scripts/BasicModule.gd"

export var Max_Hyd=1000.0
var Now_Hyd=0.0

func _ready():
	add_to_group("HydStore")
