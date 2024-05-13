extends Node

@onready var score_label = $Hud/ScoreLabel
@onready var lives_label = $Hud/LivesLabel

func _ready():
	lives_label.text =  "Lives: " + str(Autoload.lives)
	score_label.text = "Score: " + str(Autoload.score)

func add_point():
	Autoload.score += 1
	score_label.text = "Score: " + str(Autoload.score)
