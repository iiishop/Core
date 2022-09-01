extends Node

var MaxID=2
var MousePoint

func _ready():
	InitMaxID()
	MousePoint=get_parent().get_node("../Core/ModuleManager/MousePoint")
	for i in range(MaxID):
		if ConfigHelper.Modules.by_id(i+2).name!="":
			get_node("../ModulesList").add_item(ConfigHelper.Modules.by_id(i+2).name)
	get_node("../ModulesList").add_item("------------------")
	get_node("../ModulesList").add_item("删除(右键使用)")


func InitMaxID():
	while ConfigHelper.Modules.has_id(MaxID):
		MaxID+=1
	MaxID-=2

func _physics_process(delta):
	if WorldVar.Is_In_Creating_Mode:
		if Input.is_action_just_pressed("Rotate_Module") and MousePoint.get_child_count()!=0:
			MousePoint.get_child(0).rotation+=0.5*PI
			var m
			m=MousePoint.get_child(0).Can_Build_Up
			MousePoint.get_child(0).Can_Build_Up=MousePoint.get_child(0).Can_Build_Left
			MousePoint.get_child(0).Can_Build_Left=MousePoint.get_child(0).Can_Build_Down
			MousePoint.get_child(0).Can_Build_Down=MousePoint.get_child(0).Can_Build_Right
			MousePoint.get_child(0).Can_Build_Right=m
			if MousePoint.get_child(0).is_in_group("Engine"):
				if MousePoint.get_child(0).Can_Build_Up:
					MousePoint.get_child(0).Face=0
				if MousePoint.get_child(0).Can_Build_Down:
					MousePoint.get_child(0).Face=1
				if MousePoint.get_child(0).Can_Build_Left:
					MousePoint.get_child(0).Face=2
				if MousePoint.get_child(0).Can_Build_Right:
					MousePoint.get_child(0).Face=3


func _on_ModulesList_item_selected(index):
	if index!=get_node("../ModulesList").get_item_count()-2:
		if index==get_node("../ModulesList").get_item_count()-1:
			get_node("../ModuleDescription").text="删除一个已放置的模块，被删除的模块必须不是其他现存模块的存在依赖"
			for i in MousePoint.get_children():
				i.queue_free()
			MousePoint.add_child(load("res://scenes/DeleteIcon.tscn").instance())
		else:
			get_node("../ModuleDescription").text=ConfigHelper.Modules.by_id(index+2).description
			for i in MousePoint.get_children():
				i.queue_free()
			MousePoint.add_child(load(ConfigHelper.Modules.by_id(index+2).path).instance())
	else:
		get_node("../ModuleDescription").text=""
		for i in get_parent().get_parent().get_node("Core/ModuleManager/MousePoint").get_children():
			i.free()
	


func _on_Button_button_up():				#离开空间站
	
	get_node("../PlayerInterface/HPInterface/InterfaceModules").RefreshModules()
	get_parent().get_parent().get_node("GUI/WeaponGroup/WeaponGroup").RefreshWeaponModules()
	get_parent().get_parent().get_node("GUI/WeaponGroup/WeaponGroup/WeaponGroupInterface").RefreshModules()
	get_parent().get_parent().get_node("GUI/WeaponGroup/WeaponGroup/WeaponGroupInterface").RefreshGroup()
	get_parent().get_parent().get_node("BackGroundManager/BackGroundNow").texture=get_parent().get_parent().get_node("BackGroundManager").BackgroundNow
	
	get_node("../PlayerInterface").visible=true
	get_node("../ModulesList").visible=false
	get_node("../Control").visible=false
	
	for i in MousePoint.get_children():
		i.queue_free()
	
	get_node("../ModuleDescription").text=""
	
	get_tree().paused=false
	WorldVar.Is_In_Creating_Mode=false
	
	var ModulesManager
	ModulesManager=get_parent().get_parent().get_node("Core/ModuleManager")
	ModulesManager.Calc_Value()
	ModulesManager.PowerManage()
	ModulesManager.Calc_Center_of_Mess()
	ModulesManager.Init_Direction()
	ModulesManager.Calc_Force()
