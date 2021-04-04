extends KinematicBody


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")

const JUMP_SPEED:int = 18
const GRAVITY:int = -24

var motion = Vector3()
var MOUSE_SENSITIVITY: float = 0.05
var rotation_helper
var dir: Vector3
var camera

func _ready():
	rotation_helper = $RotationHelper
	camera = $Camera
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float)->void:
	move(delta)
	shoot()
	toggle_mouse_mode()
	jump()

func toggle_mouse_mode():
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func move(delta:float)->void:
	if Input.is_action_pressed("move_left"):
		motion.x += -1
	elif Input.is_action_pressed("move_right"):
		motion.x += 1
	else:
		motion.x = 0
		
	if Input.is_action_pressed("move_forward"):
		motion.z += -1
	elif Input.is_action_pressed("move_backwards"):
		motion.z += 1
	else:
		motion.z = 0
		
	motion.y += delta*GRAVITY	
	move_and_slide(motion.normalized(), Vector3.UP)
	
	dir = Vector3()
	
	var cam_xform = camera.get_global_transform()
	
	dir += -cam_xform.basis.z * motion.z
	dir += cam_xform.basis.x * motion.x


func jump():
	if Input.is_action_just_pressed("jump"):
		motion.y = JUMP_SPEED


func shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		add_child(bullet)
		bullet.set_as_toplevel(true)
		bullet.transform = $RotationHelper/Hand.global_transform
		bullet.velocity = -bullet.transform.basis.y*bullet.muzzle_velocity


func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
