extends Node

var Is_In_Creating_Mode=false

var WorldTime=0
var LastTime=0.0

var MaxID=1

func _physics_process(delta):
	LastTime+=delta
	if LastTime>=90:
		LastTime=0.0
		WorldTime+=1

func _ready():
	InitMaxID()

func InitMaxID():
	while ConfigHelper.Items.has_id(MaxID):
		MaxID+=1
	MaxID-=1

func Exchange(Self,Target,ItemID,n):
	Self.Store[ItemID]-=n
	Target.Store[ItemID]+=n
