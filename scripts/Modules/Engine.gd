extends "res://scripts/BasicModule.gd"


#引擎模块的基础脚本
export var Thrust=0						#引擎的推力大小
var Is_Right=false						#引擎是否在核心右边
var Is_Left=false						#引擎是否在核心左边
var Is_Up=false							#引擎是否在核心上方
var Is_Down=false						#引擎是否在核心下方
export var Working_Power_Consumption=0	#引擎在工作中新增功率使用
export var Working_Hyd_Consumption=0		#引擎在工作中单位时间氢气消耗量
export var Face=0						#引擎推进方向0前 1后 2左 3右

func _ready():
	add_to_group("Engine")
	Group()



func Group():
	if is_in_group("Up"):
		remove_from_group("Up")
	if is_in_group("Down"):
		remove_from_group("Down")
	if is_in_group("Left"):
		remove_from_group("Left")
	if is_in_group("Right"):
		remove_from_group("Right")
	
	
	if Face==0:
		add_to_group("Up")
	if Face==1:
		add_to_group("Down")
	if Face==2:
		add_to_group("Left")
	if Face==3:
		add_to_group("Right")

func Work():
	Max_Power+=Working_Power_Consumption
	get_parent().PowerManage()
func Stop():
	Max_Power-=Working_Power_Consumption
	get_parent().PowerManage()
