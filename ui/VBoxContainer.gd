extends VBoxContainer
var speed = 175
var direction = 1
@onready var label = $Label
@onready var play = %play
@onready var exit = %exit
@onready var label_2 = $Label2



func _process(delta):
	if label.position.y < 225:
	#se puede tener direction random con randi_range(-1,1)
		var offset = Vector2(0, speed * delta * direction)
		var x_offset = Vector2(speed * delta * randi_range(-1,1),0)
		label.position += offset
		#label.position += x_offset
		#var font_size = randi_range(100,101)
		label.add_theme_font_size_override("font_size", 100)
		play.position -= offset
		exit.position -= offset
		label_2.position -= offset
	else: 
		if abs(label.position.x) >5:
			direction *= -1
		var x_offset = Vector2(speed/8 * delta * direction,0)
		label.position += x_offset
		
	if abs(label.position.y) >10:
		pass
		#
	
	"""
	for child in get_children():
		child.position += offset
		
		if abs(child.position.y) > 40:
			direction *= -1
	"""
# Called when the node enters the scene tree for the first time.
func _ready():
	label.position.y = -20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

