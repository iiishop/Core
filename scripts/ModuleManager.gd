extends Node

var MaxID=1

var Store=[]

var Ship=[]
var Modules=[]


var Center_Mass:Vector2
var Total_Mass=0.0
var Moment_Of_Inertia=0.0

var Force_UP=0.0
var Force_Down=0.0
var Force_Left=0.0
var Force_Right=0.0

var Moment_UP=0.0
var Moment_Down=0.0
var Moment_Left=0.0
var Moment_Right=0.0					#

var PowerPercent=0.0

#--------------------Value-------------------
var Moment=0.0						#合力矩
var Power=0.0



func _ready():
	InitMaxID()
	Store.resize(MaxID+1)
	
	Ship=Create2DArray(500,500)
	Modules=Create2DArray(500,500)
	for i in Ship:
		for j in i:
			j=null
	Ship[0][0]=1
	
	Calc_Value()
	PowerManage()
	Calc_Center_of_Mess()
	Init_Direction()
	Calc_Force()
	
	GetShipModules()#


func _physics_process(delta):
	StoreManage()
	HydManage()
	
func InitMaxID():
	while ConfigHelper.Items.has_id(MaxID):
		MaxID+=1
	MaxID-=1

func Calc_Center_of_Mess():			#求飞船的质心位置  模块质量改变时调用
	Total_Mass=0.0
	for i in get_children():
		Total_Mass+=i.Mass
		Center_Mass+=Vector2(i.Mass*(i.position.x),i.Mass*i.position.y)
	Center_Mass/=Total_Mass

func Init_Direction():				#计算推进器相对于质心的位置  质心位置改变时调用
	for i in get_children():
		if i.is_in_group("Engine"):
			i.Is_Right=false
			i.Is_Left=false
			i.Is_Down=false
			i.Is_Up=false
			if i.position.x>Center_Mass.x:
				i.Is_Right=true
			if i.position.x<Center_Mass.x:
				i.Is_Left=true
			if i.position.y>Center_Mass.y:
				i.Is_Down=true
			if i.position.y<Center_Mass.y:
				i.Is_Up=true

func Calc_Force():					#计算运动时各方向的力  推进器信息改变时调用
	for i in get_children():
		if i.position!=Center_Mass and i.is_in_group("Engine") and i.Is_Working:
			var l=sqrt((Center_Mass-i.position).x*(Center_Mass-i.position).x+(Center_Mass-i.position).y*(Center_Mass-i.position).y)
			var f=(Center_Mass-i.position).normalized()
			f=Vector2(-f.y,f.x)
			if i.Face==0:
				if i.Is_Left:
					f=-f
					if i.Working_Hyd_Consumption!=0:
						Moment_UP+=i.Thrust*abs(f.y)*l
					else:
						Moment_UP+=i.Thrust*abs(f.y)*l*PowerPercent
				else:
					if i.Working_Hyd_Consumption!=0:
						Moment_UP-=i.Thrust*abs(f.y)*l
					else:
						Moment_UP-=i.Thrust*abs(f.y)*l*PowerPercent
				if i.Working_Hyd_Consumption!=0:
					Force_UP+=i.Thrust*(1-abs(f.y))
				else:
					Force_UP+=i.Thrust*(1-abs(f.y))*PowerPercent
			if i.Face==1:
				if i.Is_Right:
					f=-f
					if i.Working_Hyd_Consumption!=0:
						Moment_Down+=i.Thrust*abs(f.y)*l
					else:
						Moment_Down+=i.Thrust*abs(f.y)*l*PowerPercent
				else:
					if i.Working_Hyd_Consumption!=0:
						Moment_Down-=i.Thrust*abs(f.y)*l
					else:
						Moment_Down-=i.Thrust*abs(f.y)*l*PowerPercent
				if i.Working_Hyd_Consumption!=0:
					Force_Down+=i.Thrust*(1-abs(f.y))
				else:
					Force_Down+=i.Thrust*(1-abs(f.y))*PowerPercent
			if i.Face==2:
				if i.Is_Down:
					f=-f
					if i.Working_Hyd_Consumption!=0:
						Moment_Left+=i.Thrust*abs(f.x)*l
					else:
						Moment_Left+=i.Thrust*abs(f.x)*l*PowerPercent
				else:
					if i.Working_Hyd_Consumption!=0:
						Moment_Left-=i.Thrust*abs(f.x)*l
					else:
						Moment_Left-=i.Thrust*abs(f.x)*l*PowerPercent
				if i.Working_Hyd_Consumption!=0:
					Force_Left+=i.Thrust*(1-abs(f.x))
				else:
					Force_Left+=i.Thrust*(1-abs(f.x))*PowerPercent
			if i.Face==3:
				if i.Is_Up:
					f=-f
					if i.Working_Hyd_Consumption!=0:
						Moment_Right+=i.Thrust*abs(f.x)*l
					else:
						Moment_Right+=i.Thrust*abs(f.x)*l*PowerPercent
				else:
					if i.Working_Hyd_Consumption!=0:
						Moment_Right-=i.Thrust*abs(f.x)*l
					else:
						Moment_Right-=i.Thrust*abs(f.x)*l*PowerPercent
				if i.Working_Hyd_Consumption!=0:
					Force_Right+=i.Thrust*(1-abs(f.x))
				else:
					Force_Right+=i.Thrust*(1-abs(f.x))*PowerPercent

func Calc_Value():
	
	Moment=0.0
	Power=0.0
	
	for i in get_children():
		if i.Is_Working:
			i.Start()
	

func PowerManage():  #当有模块被开启或关闭，或模块的功率发生改变时调用
	var PowerNeeded=0
	for i in get_children():
		if i.Max_Power!=0 and i.Is_Working:
			PowerNeeded+=i.Max_Power
	if Power/PowerNeeded<=1:
		PowerPercent=Power/PowerNeeded
	else:
		PowerPercent=1

func HydManage():
	var count=0
	var CR=0
	for i in get_children():				#统计所有可用的氢气发生器
		if i.is_in_group("HydManufacture") and i.CDNow==0 and i.Is_Working:
			count+=1
			i.CDNow=i.CD
			CR+=i.Conversition_Rate
	if count!=0:
		CR=CR/count
	
	count=0
	for i in get_children():
		if i.is_in_group("HydStore") and i.Now_Hyd<i.Max_Hyd and i.Is_Working:
			count+=1
	if count>0 and Store[1]!=null and Store[1]!=0:
		Store[1]-=1
		for i in get_children():
			if i.is_in_group("Store") and i.Bag.Remove(1):
				break
		for i in get_children():
			if i.is_in_group("HydStore") and i.Now_Hyd<i.Max_Hyd and i.Is_Working:
				if i.Now_Hyd+CR/count*PowerPercent<=i.Max_Hyd:
					i.Now_Hyd+=CR/count*PowerPercent
				else:
					i.Now_Hyd=i.Max_Hyd




func StoreManage():
	Store.clear()
	Store.resize(MaxID+1)
	for i in get_children():
		if i.is_in_group("Store") and i.Is_Working:
			for j in i.Bag:
				if Store[j]==null:
					Store[j]=1
				else:
					Store[j]+=1




func GetShipModules():			#重写模块位置映射
	Ship=Create2DArray(500,500)
	Modules=Create2DArray(500,500)
	Ship[0][0]=1
	for i in get_children():
		if i.ID!=0:
			var LU=Vector2(i.position.x-(i.Width-1)*8,i.position.y-(i.Length-1)*8)/16
			for j in range(i.Length):
				for k in range(i.Width):
					Ship[LU.x+k][LU.y+j]=i.ID
					Modules[LU.x+k][LU.y+j]=i





func Create2DArray(w,h):
	var map=[]
	for x in range(w):
		var col=[]
		col.resize(h)
		map.append(col)
	return map








































