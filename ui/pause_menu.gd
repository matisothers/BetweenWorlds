extends MarginContainer
@onready var resume = %Resume

@onready var rmainmenu = %rmainmenu
@onready var label_2 = %Label2
@onready var retry = %Retry



# Called when the node enters the scene tree for the first time.
func _ready():
	var dicc_text=["Seending Help....","Cool cool cool","Good luck","Running out of ideas"]
	var textran = randi_range(0,len(dicc_text)-1)

	label_2.text= dicc_text[textran]

	#get_node("PanelContainer/MarginContainer/VBoxContainer/Label2").text = str("bachata")
	
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
	
	



