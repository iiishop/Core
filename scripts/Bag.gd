extends WindowDialog


onready var ModuleManager=get_parent().get_parent().get_parent().get_node("Core/ModuleManager")

func _physics_process(delta):
	Refrash_StoreList()

func Refrash_StoreList():
	var Max=0.0
	var Now=0.0
	get_node("Name").clear()
	get_node("Price").clear()
	get_node("Weight").clear()
	get_node("Name").add_item("物品名称/数量")
	get_node("Name").add_item("-------------------------")
	get_node("Weight").add_item("单质量/总质量")
	get_node("Weight").add_item("-----------------")
	get_node("Price").add_item("标准单价/总价")
	get_node("Price").add_item("----------------")
	for i in range(ModuleManager.Store.size()):
		if ModuleManager.Store[i]!=null:
			ShowItem(i)
			Now+=ConfigHelper.Items.by_id(i).weight*ModuleManager.Store[i]
	get_node("Label").text=str(Now)

func ShowItem(ID):
	get_node("Name").add_item(str(ConfigHelper.Items.by_id(ID).name)+"/"+str(ModuleManager.Store[ID]))
	get_node("Weight").add_item(str(ConfigHelper.Items.by_id(ID).weight)+"/"+str(ConfigHelper.Items.by_id(ID).weight*ModuleManager.Store[ID]))
	get_node("Price").add_item(str(ConfigHelper.Items.by_id(ID).price)+"/"+str(ConfigHelper.Items.by_id(ID).price*ModuleManager.Store[ID]))
