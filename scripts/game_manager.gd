extends Node

@onready var score_label = $Hud/ScoreLabel
@onready var lives_label = $Hud/LivesLabel
@onready var time_label = $Hud/TimeLabel
@onready var timer = $Timer

var elapsed_time = 0

func _ready():
	lives_label.text =  "Lives: " + str(Autoload.lives)
	score_label.text = "Score: " + str(Autoload.score)
	time_label.text = "Time: " + str(Autoload.time)

func add_point():
	Autoload.score += 1
	score_label.text = "Score: " + str(Autoload.score)

func _on_timer_timeout():
	elapsed_time += 1
	Autoload.time = elapsed_time

	time_label.text = str("Time: %d" % elapsed_time)
