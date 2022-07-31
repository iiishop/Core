extends "res://scripts/BasicModule.gd"

export var Power=0.0


func _ready():
	add_to_group("Generator")

func Start():
	get_parent().Power+=Power


func ModuleDeath():
	get_parent().Power-=Power
	get_parent().PowerManage()
	get_parent().Calc_Force()
