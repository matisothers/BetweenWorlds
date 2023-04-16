extends Node2D


@onready var maps = [$TileMap_Nature,$TileMap_Futuristic]
var world = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	maps[0].set_layer_enabled(0,true)
	maps[1].set_layer_enabled(0,false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("change"):
		world =  (world + 1) % 2
		maps[world].set_layer_enabled(0,true)
		
		
	maps[1].modulate.a = move_toward(maps[1].modulate.a,world,0.03)
	maps[0].modulate.a = move_toward(maps[0].modulate.a,(world+1)%2,0.03)
	
	if maps[(world + 1) % 2].modulate.a < 0.3:
		maps[(world + 1) % 2].set_layer_enabled(0,false)

	
