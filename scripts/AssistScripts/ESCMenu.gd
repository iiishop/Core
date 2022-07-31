extends CanvasLayer

export(NodePath) var player_node_path
var Save_Path="user://save_config_file.ini"

func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	#print(get_node(player_node_path).position)
	pass




func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			get_node("Control").visible=!get_node("Control").visible
			get_tree().paused=!get_tree().paused



func Save():
	var config=ConfigFile.new()
	var Player=get_node(player_node_path)
	
	config.set_value("player","position",Player.position)
	config.set_value("player","rotation",Player.rotation)
	
	config.save(Save_Path)

func Load():
	var config=ConfigFile.new()
	var Player=get_node(player_node_path)
	
	config.load(Save_Path)
	
	Player.position=config.get_value("player","position")

	
	Player.rotation=config.get_value("player","rotation")


func _on_Button_button_up():
	Save()






func _on_load_button_up():
	Load()
