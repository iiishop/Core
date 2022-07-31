extends "res://scripts/BasicModule.gd"


export var Moment=0						#可以提供的最大力矩


func _ready():
	add_to_group("Rotor")
	
func Start():
	get_parent().Moment+=Moment

func ModuleDeath():
	Is_Working=false
	get_parent().Moment-=Moment
	
