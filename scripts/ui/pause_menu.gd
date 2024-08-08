extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	$PanelContainer/VBoxContainer/ResumeButton.grab_focus()
	

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()



func _process(_delta):
	testEsc()


func _on_resume_button_pressed():
	resume()

func _on_quit_button_pressed():
	resume()
	get_tree().change_scene_to_file('res://scenes/ui/main_menu.tscn')
