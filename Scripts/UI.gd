extends CanvasLayer


func _on_Pause_toggled(button_pressed:bool):
	if(button_pressed):
		$PauseDialog.show()


func _on_Player_update_health(health:float):
	health = clamp(health, 0.0, 1.0)
	var healthBar = $HBoxContainer/VBoxContainer/HealthBar as ProgressBar
	healthBar.value = health*100
	
