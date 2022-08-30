extends WindowDialog

onready var GalaxyMap=GalaxyManager.GalaxyMap
onready var CampMap=CampManager.CampMap



func _ready():
	for i in CampMap:
		get_node("ItemList").add_item(i.Name)

