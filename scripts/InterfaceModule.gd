extends Node2D


onready var ModuleManager = get_node("/root/World/Core/ModuleManager")
var Modules=[]

func _ready():
	RefreshModules()

func _physics_process(delta):
	RefreshColor()

func RefreshModules():						#飞船模块变动时调用
	for i in get_children():
		i.queue_free()
	Modules.clear()
	
	var t=load("res://scenes/InterfaceModule.tscn").instance()
	t.add_child(Sprite.new())
	t.get_child(1).texture=load("res://png/ui/gui_4_2_3.png")
	t.get_child(1).scale=Vector2(2,2)
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


func RefreshColor():
	for i in range(Modules.size()):
		if Modules[i].HP/Modules[i].MaxHP==1:
			get_child(i).self_modulate=Color.white
		elif Modules[i].HP/Modules[i].MaxHP>=0.8:
			get_child(i).self_modulate=Color.chartreuse
		elif Modules[i].HP/Modules[i].MaxHP>=0.5:
			get_child(i).self_modulate=Color.yellowgreen
		elif Modules[i].HP/Modules[i].MaxHP>=0.3:
			get_child(i).self_modulate=Color.goldenrod
		elif Modules[i].HP/Modules[i].MaxHP>0:
			get_child(i).self_modulate=Color.webmaroon
		elif Modules[i].HP/Modules[i].MaxHP==0:
			get_child(i).self_modulate=Color.darkgray
