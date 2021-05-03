extends MeshInstance


onready var Bullet = preload("res://Scenes/Players/Bullet.tscn")



func fire():
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
