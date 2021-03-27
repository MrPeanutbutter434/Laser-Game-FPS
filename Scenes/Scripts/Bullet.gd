extends Area

signal exploded

export var muzzle_velocity = 250
export var g = Vector3.DOWN*5


export var velocity = Vector3.ZERO



func _physics_process(delta):
	#velocity += delta*g
	#look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity*delta


func _on_Bullet_body_entered(body):
	print(body)
	emit_signal("exploded", transform.origin)

