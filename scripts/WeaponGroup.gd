extends WindowDialog


onready var ModuleManager=get_parent().get_parent().get_parent().get_node("Core/ModuleManager")
var ID=-1
var Weapons=[]


func _ready():
	RefreshWeaponModules()


func RefreshWeaponModules():
	get_node("ItemList").clear()
	Weapons.clear()
	
	for i in ModuleManager.get_children():
		if i.is_in_group("Weapon1"):
			get_node("ItemList").add_item("1 "+str(i.NAME))
			Weapons.append(i)
		elif i.is_in_group("Weapon2"):
			get_node("ItemList").add_item("2 "+str(i.NAME))
			Weapons.append(i)
		elif i.is_in_group("Weapon3"):
			get_node("ItemList").add_item("3 "+str(i.NAME))
			Weapons.append(i)
		elif i.is_in_group("Weapon4"):
			get_node("ItemList").add_item("4 "+str(i.NAME))
			Weapons.append(i)
		elif i.is_in_group("Weapon5"):
			get_node("ItemList").add_item("5 "+str(i.NAME))
			Weapons.append(i)
		elif i.is_in_group("WeaponAuto"):
			get_node("ItemList").add_item("A "+str(i.NAME))
			Weapons.append(i)



func _on_Button_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			pass
		elif i.is_in_group("Weapon2"):
			i.remove_from_group("Weapon2")
			i.add_to_group("Weapon1")
		elif i.is_in_group("Weapon3"):
			i.remove_from_group("Weapon3")
			i.add_to_group("Weapon1")
		elif i.is_in_group("Weapon4"):
			i.remove_from_group("Weapon4")
			i.add_to_group("Weapon1")
		elif i.is_in_group("Weapon5"):
			i.remove_from_group("Weapon5")
			i.add_to_group("Weapon1")
		elif i.is_in_group("WeaponAuto"):
			i.remove_from_group("WeaponAuto")
			i.add_to_group("Weapon1")
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_Button2_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			i.remove_from_group("Weapon1")
			i.add_to_group("Weapon2")
		elif i.is_in_group("Weapon2"):
			pass
		elif i.is_in_group("Weapon3"):
			i.remove_from_group("Weapon3")
			i.add_to_group("Weapon2")
		elif i.is_in_group("Weapon4"):
			i.remove_from_group("Weapon4")
			i.add_to_group("Weapon2")
		elif i.is_in_group("Weapon5"):
			i.remove_from_group("Weapon5")
			i.add_to_group("Weapon2")
		elif i.is_in_group("WeaponAuto"):
			i.remove_from_group("WeaponAuto")
			i.add_to_group("Weapon2")
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_Button3_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			i.remove_from_group("Weapon1")
			i.add_to_group("Weapon3")
		elif i.is_in_group("Weapon2"):
			i.remove_from_group("Weapon2")
			i.add_to_group("Weapon3")
		elif i.is_in_group("Weapon3"):
			pass
		elif i.is_in_group("Weapon4"):
			i.remove_from_group("Weapon4")
			i.add_to_group("Weapon3")
		elif i.is_in_group("Weapon5"):
			i.remove_from_group("Weapon5")
			i.add_to_group("Weapon3")
		elif i.is_in_group("WeaponAuto"):
			i.remove_from_group("WeaponAuto")
			i.add_to_group("Weapon3")
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_Button4_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			i.remove_from_group("Weapon1")
			i.add_to_group("Weapon4")
		elif i.is_in_group("Weapon2"):
			i.remove_from_group("Weapon2")
			i.add_to_group("Weapon4")
		elif i.is_in_group("Weapon3"):
			i.remove_from_group("Weapon3")
			i.add_to_group("Weapon4")
		elif i.is_in_group("Weapon4"):
			pass
		elif i.is_in_group("Weapon5"):
			i.remove_from_group("Weapon5")
			i.add_to_group("Weapon4")
		elif i.is_in_group("WeaponAuto"):
			i.remove_from_group("WeaponAuto")
			i.add_to_group("Weapon4")
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_Button5_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			i.remove_from_group("Weapon1")
			i.add_to_group("Weapon5")
		elif i.is_in_group("Weapon2"):
			i.remove_from_group("Weapon2")
			i.add_to_group("Weapon5")
		elif i.is_in_group("Weapon3"):
			i.remove_from_group("Weapon3")
			i.add_to_group("Weapon5")
		elif i.is_in_group("Weapon4"):
			i.remove_from_group("Weapon4")
			i.add_to_group("Weapon5")
		elif i.is_in_group("Weapon5"):
			pass
		elif i.is_in_group("WeaponAuto"):
			i.remove_from_group("WeaponAuto")
			i.add_to_group("Weapon5")
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_Button6_pressed():
	if ID!=-1:
		var i
		i=Weapons[ID]
		
		if i.is_in_group("Weapon1"):
			i.remove_from_group("Weapon1")
			i.add_to_group("WeaponAuto")
		elif i.is_in_group("Weapon2"):
			i.remove_from_group("Weapon2")
			i.add_to_group("WeaponAuto")
		elif i.is_in_group("Weapon3"):
			i.remove_from_group("Weapon3")
			i.add_to_group("WeaponAuto")
		elif i.is_in_group("Weapon4"):
			i.remove_from_group("Weapon4")
			i.add_to_group("WeaponAuto")
		elif i.is_in_group("Weapon5"):
			i.remove_from_group("Weapon5")
			i.add_to_group("WeaponAuto")
		elif i.is_in_group("WeaponAuto"):
			pass
		
		RefreshWeaponModules()
		get_node("WeaponGroupInterface").RefreshGroup()


func _on_ItemList_item_selected(index):
	ID=index
