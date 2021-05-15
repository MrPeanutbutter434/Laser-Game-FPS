extends MeshInstance

const DAMAGE = 6


func fire():
	var ray = $RayCast as RayCast
	
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var body = ray.get_collider()
		
		if body.has_method("bullet_hit"):
			body.bullet_hit(DAMAGE)
