extends Area

signal exploded

export var muzzle_velocity = 10
export var g = Vector3.DOWN*10


export var velocity = Vector3.ZERO


func _physics_process(delta:float)->void:
	var forward = global_transform.basis.z.normalized()
	global_translate(forward*muzzle_velocity*delta)
	


func _on_Bullet_body_entered(body):
	emit_signal("exploded", transform.origin)
	#queue_free()

