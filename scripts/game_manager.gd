extends Node

#var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	Autoload.score += 1
	score_label.text = "You collected " + str(Autoload.score) + " coins."
