extends MarginContainer
@onready var resume = %Resume
@onready var retry = %Retry
@onready var rmainmenu = %rmainmenu


# Called when the node enters the scene tree for the first time.
func _ready():
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	rmainmenu.pressed.connect(_on_rmainmenu_pressed)
	hide()
func _input(event):
	if event.is_action_pressed("pause"):
		show()
		get_tree().paused = true
		
func _on_resume_pressed():
	get_tree().paused = false
	hide()
func _on_retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
	
func _on_rmainmenu_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu.tscn")
	get_tree().paused = false
	
	



