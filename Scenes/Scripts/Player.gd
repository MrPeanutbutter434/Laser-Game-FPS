extends KinematicBody


# Declare member variables here. Examples:
var motion = Vector3()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()


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
