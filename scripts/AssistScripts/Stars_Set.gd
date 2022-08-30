extends Node2D


func _ready():
	for i in GalaxyManager.GalaxyMap:
		var t=load("res://scenes/Star.tscn").instance()
		add_child(t)
		t.ID=i.ID
		t.position=i.Pos
