extends Node

var slot : int = 1

var score : int = 0
var time	: int = 0
var lives : int = 3
var health :	int = 100

var level : = 1

const MAX_HEALTH = 100

func death():
	lives -= 1

func check_and_do_level_reset():
	if lives <= 0:
		lives = 3
		score = 0
		health = MAX_HEALTH
