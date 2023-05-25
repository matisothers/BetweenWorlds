extends ParallaxLayer

var BackgroundSpeed = -30

@onready var clouds_2 = $Clouds2
@onready var clouds = $Clouds



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	self.motion_offset.x += BackgroundSpeed *delta
