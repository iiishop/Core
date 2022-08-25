extends Sprite
onready var GalaxyManager=get_node("/root/World/GalaxyManager")
onready var CampManager=get_node("/root/World/CampManager")

func _physics_process(delta):
	if visible:
		global_position=get_global_mouse_position()


func _on_Galaxy_mouse_entered():
	#get_node("GalaxyName")
	if GalaxyManager.GalaxyMap[get_parent().ID].Camp>-1:
		get_node("GalaxyCamp").text="阵营:"+CampManager.CampMap[GalaxyManager.GalaxyMap[get_parent().ID].Camp].Name
	else:
		get_node("GalaxyCamp").text="无阵营"
