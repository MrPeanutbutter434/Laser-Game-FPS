extends Area

signal exploded

export var muzzle_velocity = 25
export var g = Vector3.DOWN*20


var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity += g*delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity*delta


func _on_Bullet_body_entered(body):
	emit_signal("exploded", transform.origin)
