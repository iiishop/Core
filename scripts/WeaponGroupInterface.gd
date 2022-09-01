extends Node2D


onready var ModuleManager = get_node("/root/World/Core/ModuleManager")
var Modules=[]

func _ready():
	RefreshModules()


func _physics_process(delta):
	RefreshGroup()

func RefreshModules():						#飞船模块变动时调用
	for i in get_children():
		i.queue_free()
	Modules.clear()
	
	var t=load("res://scenes/InterfaceModule.tscn").instance()
	t.add_child(Sprite.new())
	t.get_child(2).texture=load("res://png/ui/gui_4_2_3.png")
	t.get_child(2).scale=Vector2(2,2)
	add_child(t)
	t.position=Vector2.ZERO
	Modules.append(get_node("/root/World/Core"))
	
	for i in ModuleManager.get_children():
		if i.ID!=0:
			t=load("res://scenes/InterfaceModule.tscn").instance()
			add_child(t)
			t.scale=i.scale
			t.position=i.position
			Modules.append(i)


func RefreshGroup():
	for i in range(Modules.size()):
		if Modules[i].is_in_group("Weapon1"):
			get_child(i).get_child(1).texture=load("res://png/Latter/1.png")
		elif Modules[i].is_in_group("Weapon2"):
			get_child(i).get_child(1).texture=load("res://png/Latter/2.png")
		elif Modules[i].is_in_group("Weapon3"):
			get_child(i).get_child(1).texture=load("res://png/Latter/3.png")
		elif Modules[i].is_in_group("Weapon4"):
			get_child(i).get_child(1).texture=load("res://png/Latter/4.png")
		elif Modules[i].is_in_group("Weapon5"):
			get_child(i).get_child(1).texture=load("res://png/Latter/5.png")
		elif Modules[i].is_in_group("WeaponAuto"):
			get_child(i).get_child(1).texture=load("res://png/Latter/A.png")
