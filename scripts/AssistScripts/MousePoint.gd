extends "res://scripts/BasicModule.gd"



var passed=[]


func _physics_process(delta):
	global_position=get_global_mouse_position()
	
	
	
	
	
	
	var ShouldPosition
	var ModulePositionCheck=true#=ShouldPosition/16	#检查新模块当前位置是否可以放置
	var ModulesRelationCheck=false
	
	if get_child_count()!=0:
		
		
		
		if get_child(0).name!="DeleteIcon":
			ShouldPosition=Vector2((int((position.x+8)/16)*16 if position.x>0 else int((position.x-8)/16)*16) if get_child(0).Width %2==1 else (int((position.x)/16)*16+8 if position.x>0 else int((position.x)/16)*16-8) ,(int((position.y+8)/16)*16 if position.y>0 else int((position.y-8)/16)*16) if get_child(0).Length %2==1 else (int((position.y)/16)*16+8 if position.y>0 else int((position.y)/16)*16-8))
		else:
			ShouldPosition=Vector2((int((position.x+8)/16)*16 if position.x>0 else int((position.x-8)/16)*16) ,(int((position.y+8)/16)*16 if position.y>0 else int((position.y-8)/16)*16))
		
		get_child(0).position=ShouldPosition-position
		
		
		if Input.is_action_just_pressed("Shoot2") and get_child(0).name=="DeleteIcon":
			var LU=Vector2(ShouldPosition.x,ShouldPosition.y)/16
			if ShouldPosition!=Vector2.ZERO and get_parent().Modules[LU.x][LU.y]!=null:
				if Check(get_parent().Modules[LU.x][LU.y]):
					get_parent().get_parent().get_node(get_parent().Modules[LU.x][LU.y].name+"C").free()
					get_parent().Modules[LU.x][LU.y].free()
					get_parent().GetShipModules()



		if Input.is_action_just_pressed("Shoot1") and get_child(0).name!="DeleteIcon": 	#放置物块
			var LU=Vector2(ShouldPosition.x-(get_child(0).Width-1)*8,ShouldPosition.y-(get_child(0).Length-1)*8)/16
			for i in range(get_child(0).Length):
				for j in range(get_child(0).Width):
					if get_parent().Ship[LU.x+j][LU.y+i]!=null:	#位置已被占用
						ModulePositionCheck=false
					if i==0 and get_parent().Ship[LU.x+j][LU.y+i-1]!=null:#上方有物块
						if get_child(0).Can_Build_Up:
							if get_parent().Ship[LU.x+j][LU.y+i-1]==1 or get_parent().Modules[LU.x+j][LU.y+i-1].Can_Build_Down:
								ModulesRelationCheck=true
								
					if i==get_child(0).Length-1 and get_parent().Ship[LU.x+j][LU.y+i+1]!=null:
						if get_child(0).Can_Build_Down:
							if get_parent().Ship[LU.x+j][LU.y+i+1]==1 or get_parent().Modules[LU.x+j][LU.y+i+1].Can_Build_Up:
								ModulesRelationCheck=true
							
					if j==0 and get_parent().Ship[LU.x+j-1][LU.y+i]!=null:
						if get_child(0).Can_Build_Left:
							if get_parent().Ship[LU.x+j-1][LU.y+i]==1 or get_parent().Modules[LU.x+j-1][LU.y+i].Can_Build_Right:
								ModulesRelationCheck=true
							
					if j==get_child(0).Width-1 and get_parent().Ship[LU.x+j+1][LU.y+i]!=null:
						if get_child(0).Can_Build_Right:
							if get_parent().Ship[LU.x+j+1][LU.y+i]==1 or get_parent().Modules[LU.x+j+1][LU.y+i].Can_Build_Left:
								ModulesRelationCheck=true
			
			if ModulePositionCheck and ModulesRelationCheck:
				var t=load(ConfigHelper.Modules.by_id(get_child(0).ID).path).instance()
				get_parent().add_child(t)
				t.position=ShouldPosition
				t.rotation=get_child(0).rotation
				t.Can_Build_Up=get_child(0).Can_Build_Up
				t.Can_Build_Down=get_child(0).Can_Build_Down
				t.Can_Build_Left=get_child(0).Can_Build_Left
				t.Can_Build_Right=get_child(0).Can_Build_Right
				if t.is_in_group("Engine"):
					t.Face=get_child(0).Face
					t.Group()
				get_parent().GetShipModules()
				t.Col()
				t.name=t.name.replace("@","")
				get_parent().get_parent().get_child(0).call_deferred("Create")

func Check(M):
	
	var LU=Vector2(M.position.x-(M.Width-1)*8,M.position.y-(M.Length-1)*8)/16
	var RD=Vector2(M.position.x+(M.Width-1)*8,M.position.y+(M.Length-1)*8)/16
	var UP
	var LEFT
	var DOWN
	var RIGHT
	for i in range(M.Width):
		UP=get_parent().Modules[LU.x+i][LU.y-1]
		DOWN=get_parent().Modules[LU.x+i][RD.y+1]
		if UP!=null:
			if M.Can_Build_Up and UP.Can_Build_Down:
				passed.clear()
				passed.append(M)
				if !CheckT(UP):
					return false
		if DOWN!=null:
			if M.Can_Build_Down and DOWN.Can_Build_Up:
				passed.clear()
				passed.append(M)
				if !CheckT(DOWN):
					return false
	for i in range(M.Length):
		LEFT=get_parent().Modules[LU.x-1][LU.y+i]
		RIGHT=get_parent().Modules[RD.x+1][LU.y+i]
		if LEFT!=null:
			if M.Can_Build_Left and LEFT.Can_Build_Right:
				passed.clear()
				passed.append(M)
				if !CheckT(LEFT):
					return false
		if RIGHT!=null:
			if M.Can_Build_Right and RIGHT.Can_Build_Left:
				passed.clear()
				passed.append(M)
				if !CheckT(RIGHT):
					return false
	return true

func CheckT(M):
	
	passed.append(M)
	var LU=Vector2(M.position.x-(M.Width-1)*8,M.position.y-(M.Length-1)*8)/16
	var RD=Vector2(M.position.x+(M.Width-1)*8,M.position.y+(M.Length-1)*8)/16
	var UP
	var LEFT
	var DOWN
	var RIGHT
	for i in range(M.Width):
		if Vector2(LU.x+i,LU.y-1)==Vector2.ZERO:
			if M.Can_Build_Up:
				return true
		if Vector2(LU.x+i,RD.y+1)==Vector2.ZERO:
			if M.Can_Build_Down:
				return true
	for i in range(M.Length):
		if Vector2(LU.x-1,LU.y+i)==Vector2.ZERO:
			if M.Can_Build_Left:
				return true
		if Vector2(RD.x+1,LU.y+i)==Vector2.ZERO:
			if M.Can_Build_Right:
				return true
	for i in range(M.Width):
		UP=get_parent().Modules[LU.x+i][LU.y-1]
		DOWN=get_parent().Modules[LU.x+i][RD.y+1]
		if UP!=null:
			if !UP in passed and M.Can_Build_Up and UP.Can_Build_Down:
				if CheckT(UP):
					return true
		if DOWN!=null:
			if !DOWN in passed and M.Can_Build_Down and DOWN.Can_Build_Up:
				if CheckT(DOWN):
					return true
	for i in range(M.Length):
		LEFT=get_parent().Modules[LU.x-1][LU.y+i]
		RIGHT=get_parent().Modules[RD.x+1][LU.y+i]
		if LEFT!=null:
			if !LEFT in passed and M.Can_Build_Left and LEFT.Can_Build_Right:
				if CheckT(LEFT):
					return true
		if RIGHT!=null:
			if !RIGHT in passed and M.Can_Build_Right and RIGHT.Can_Build_Left:
				if CheckT(RIGHT):
					return true
	return false
