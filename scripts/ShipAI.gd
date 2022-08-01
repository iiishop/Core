extends Node


func _ready():
	pass 


enum {
	Attack,
	Idle
}

func Attack():
	for i in get_node("Manager").get_children():
		if i.is_in_group("ImmobileMissileLauncher") or i.is_in_group("Turret"):
			pass
		elif i.is_in_group("RotationTurret") or i.is_in_group("MissileLauncher"):
			pass

func Idle():
	pass
