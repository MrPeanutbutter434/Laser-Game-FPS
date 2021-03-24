extends KinematicBody


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")


# Declare member variables here. Examples:
var motion = Vector3()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	shoot()


func move():
	if Input.is_action_pressed("move_left"):
		motion.z = -1
	elif Input.is_action_pressed("move_right"):
		motion.z = 1
	else:
		motion.z = 0
		
	if Input.is_action_pressed("move_forward"):
		motion.x = 1
	elif Input.is_action_pressed("move_backwards"):
		motion.x = -1
	else:
		motion.x = 0
		
	move_and_slide(motion.normalized(), Vector3.UP)


func shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		owner.add_child(bullet)
		bullet.transform = $Hand.global_transform
		bullet.velocity = -bullet.transform.basis.z*bullet.muzzle_velocity
