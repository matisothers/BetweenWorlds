

extends ParallaxBackground
@onready var play = %play
@onready var exit = %exit
@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Label






# Called when the node enters the scene tree for the first time.
func _ready():
	play.pressed.connect(_on_play_pressed)

	exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	LevelManager.next_level()

	
func _on_exit_pressed():
	get_tree().quit()
	


# Syntax: [ghost freq=5.0 span=10.0][/ghost]




