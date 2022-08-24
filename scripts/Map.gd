extends WindowDialog

onready var GalaxyMap=get_node("/root/World/GalaxyManager").GalaxyMap
onready var CampMap=get_node("/root/World/CampManager").CampMap



func _ready():
	for i in CampMap:
		get_node("ItemList").add_item(i.Name)

