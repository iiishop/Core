extends RigidBody2D

export var ID=0
export var Force=0.0
export var Moment=0.0
export var CD=0.0
export var Hurt=0.0
export(PackedScene) var Explode
var Enemy=null
var is_dead=false



func Shoot():
	get_node("Particles2D").emitting=true
	applied_force=Vector2(Force,0).rotated(rotation)
	get_node("Particles2D").process_material.initial_velocity=linear_velocity.length()

func _physics_process(delta):
	
	if CD>0:
		CD-=delta
	elif !is_dead:
		Explode()
	
	
	
	if Enemy!=null:
		var angleT=(Vector2(1,0).rotated(rotation)).angle_to(Enemy.global_position-global_position)
		linear_velocity=Vector2(linear_velocity.length(),0).rotated(rotation)
		if angleT>0.1:
			applied_torque=Moment
			applied_force=Vector2.ZERO
		elif angleT<-0.1:
			applied_torque=-Moment
			applied_force=Vector2.ZERO
		else:
			look_at(Enemy.global_position)
			applied_torque=0
			angular_velocity=0
			applied_force=Vector2(Force,0).rotated(rotation)



func _on_EnemyCheck_body_entered(body):
	if Enemy==null:
		Enemy=body


func _on_EnemyCheck_body_exited(body):
	if body==Enemy:
		Enemy=null


func Explode():
	var e=Explode.instance()
	add_child(e)
	get_node("Sprite").visible=false
	get_node("Particles2D").visible=false
	is_dead=true
	linear_velocity=Vector2(0,0)
	yield(get_tree().create_timer(1.5), "timeout")
	for i in get_children():
		i.queue_free()
	queue_free()

func _on_Missile_body_entered(body):
	if !is_dead:
		Explode()



