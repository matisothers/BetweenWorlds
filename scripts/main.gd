extends Node2D

@onready var tile_map_nature = $TileMap_Nature
@onready var tile_map_futuristic = $TileMap_Futuristic




# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map_nature.set_layer_enabled(0,(World.world+1)%2)
	tile_map_futuristic.set_layer_enabled(0,World.world)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("change"):
		World.world =  (World.world + 1) % 2
		tile_map_nature.set_layer_enabled(0,(World.world+1)%2)
		tile_map_futuristic.set_layer_enabled(0,World.world)
		
	tile_map_futuristic.modulate.a = move_toward(tile_map_futuristic.modulate.a,World.world,0.1)
	tile_map_nature.modulate.a = move_toward(tile_map_nature.modulate.a,(World.world+1)%2,0.1)
	
