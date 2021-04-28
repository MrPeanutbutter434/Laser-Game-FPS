extends Node2D


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
