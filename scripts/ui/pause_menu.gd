extends Control

@onready var animation_player = $AnimationPlayer
@onready var resume_button = $PanelContainer/VBoxContainer/ResumeButton
@onready var quit_button = $PanelContainer/VBoxContainer/QuitButton

func _ready():
	animation_player.play("RESET")

func resume():
	get_tree().paused = false
	animation_player.play_backwards("blur")
	resume_button.release_focus()
	quit_button.release_focus()
	

func pause():
	get_tree().paused = true
	animation_player.play("blur")
	resume_button.grab_focus()


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
	Music.emit_signal("main_menu")
	get_tree().change_scene_to_file('res://scenes/ui/main_menu.tscn')
