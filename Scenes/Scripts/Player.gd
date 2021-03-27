extends KinematicBody


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")

const JUMP_SPEED = 18

var motion = Vector3()
var MOUSE_SENSITIVITY = 0.05
var rotation_helper

func _ready():
	rotation_helper = $RotationHelper
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		add_child(bullet)
		bullet.set_as_toplevel(true)
		bullet.transform = $RotationHelper/Hand.global_transform
		bullet.velocity = -bullet.transform.basis.y*bullet.muzzle_velocity


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
