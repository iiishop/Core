extends Node2D


onready var ModuleManager = get_node("/root/World/Core/ModuleManager")

func _ready():
	RefreshModules()

func RefreshModules():						#飞船模块变动时调用
	for i in get_children():
		i.queue_free()
	
	var t=load("res://scenes/InterfaceModule.tscn").instance()
	add_child(t)
	t.position=Vector2.ZERO
	
	for i in ModuleManager.get_children():
		if i.ID!=0:
			t=load("res://scenes/InterfaceModule.tscn").instance()
			add_child(t)
			t.scale=i.scale
			t.position=i.position
			
