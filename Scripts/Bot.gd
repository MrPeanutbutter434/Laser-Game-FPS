extends KinematicBody


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")


func _ready():
	$Timer.start()


func _process(delta):
	pass


func shoot():
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.transform = $RotationHelper/Hand.global_transform
	bullet.velocity = -bullet.transform.basis.y*bullet.muzzle_velocity


func _on_Timer_timeout():
	shoot()


func _on_Player_player_position(position:Vector3):
	look_at(position, Vector3(0,1,0))
	rotate_object_local(Vector3(1, 0, 0), PI/2)

