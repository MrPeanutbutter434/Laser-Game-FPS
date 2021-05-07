extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Pause_toggled(button_pressed:bool):
	if(button_pressed):
		$PauseDialog.show()


func _on_Player_update_health(health:float):
	var healthBar = $HBoxContainer/VBoxContainer/HealthBar as ProgressBar
	healthBar.value = health*100
	
