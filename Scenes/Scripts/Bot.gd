extends KinematicBody

onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")


func _ready():
	$Timer.start()


#func _process(delta):
#	pass


func shoot():
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.transform = $RotationHelper/Hand.global_transform
	bullet.velocity = -bullet.transform.basis.y*bullet.muzzle_velocity




func _on_Timer_timeout():
	shoot()
