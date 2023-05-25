extends ParallaxLayer

var BackgroundSpeed = -20

@onready var clouds_2 = $Clouds2
@onready var clouds = $Clouds
@onready var player = $"../../../Player"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	var vel_p= player.velocity.x
	self.motion_offset.x += -vel_p * 1/10 *delta
	
