extends KinematicBody

class_name Player


signal player_position(position)


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")


const JUMP_SPEED:int = 18
const GRAVITY:int = -24
const MAX_SPEED: int = 20
const MAX_SLOPE_ANGLE:int = 40
const ACCEL:int = 2
const DEACCEL:int = 4

var motion = Vector2()
var MOUSE_SENSITIVITY: float = 0.05
var rotation_helper
var dir: Vector3
var vel: Vector3
var camera: Camera

func _ready():
	rotation_helper = $RotationHelper
	camera = $Camera
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float)->void:
	move(delta)
	shoot()
	toggle_mouse_mode()
	jump()
	emit_signal("player_position", self.translation)


func toggle_mouse_mode():
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func move(delta:float)->void:
	dir = Vector3()
	vel = Vector3()
	
	if Input.is_action_pressed("move_left"):
		motion.x += -1
	elif Input.is_action_pressed("move_right"):
		motion.x += 1
	elif Input.is_action_pressed("move_forward"):
		motion.y += 1
	elif Input.is_action_pressed("move_backwards"):
		motion.y += -1
	else:
		motion.x = 0
		motion.y = 0
		

	var cam_xform = camera.get_global_transform()
	
	dir += -cam_xform.basis.z * motion.y
	dir += cam_xform.basis.x * motion.x
	
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))	


func jump():
	if Input.is_action_just_pressed("jump"):
		motion.y = JUMP_SPEED


func shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		add_child(bullet)
		bullet.set_as_toplevel(true)
		#bullet.transform = $RotationHelper/Hand.global_transform
		#bullet.velocity = -bullet.transform.basis.y*bullet.muzzle_velocity


func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
