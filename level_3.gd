extends Node2D

@onready var tile_map_nature = $TileMap_Nature
@onready var tile_map_futuristic = $TileMap_Futuristic
@onready var player = $Player
@onready var margins = $margins
var can_change = true
@onready var botom = margins.get_node("inf_der").global_position.y
@onready var top = margins.get_node("sup_izq").global_position.y
@onready var left = margins.get_node("sup_izq").global_position.x
@onready var right = margins.get_node("inf_der").global_position.x

@onready var fondo_juego = $fondo_juego
@onready var parallax_background = $fondo2/ParallaxBackground
@onready var parallax_background_2 = $fondo2/ParallaxBackground2


@onready var cant_change_world_sound = $cant_change_world_sound
@onready var change_world_sound = $change_world_sound

@onready var maps = [$TileMap_Nature,$TileMap_Futuristic]
var world = 0

var current_dialogue = 1
var dialogue = preload("res://dialogos.tscn")
var dialogue_clip = true
var messages 
# Called when the node enters the scene tree for the first time.
func _ready():

	player.set_camera_limits(
		margins.get_node("sup_izq").global_position,
		margins.get_node("inf_der").global_position
	)
	
	maps[0].tile_set.set("physics_layer_0/collision_layer", 17)
	maps[1].tile_set.set("physics_layer_0/collision_layer", 16)
	maps[0].modulate.a = 1
	maps[1].modulate.a = 0
	
	player.current_dialogue = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# dialogos
	if (player.position.x >=200 and current_dialogue == 1):
		messages = ["Hey you're doinig it right", "Now try climbing walls", "Press C next to a wall in the air", "Or just jump again"]
		player.say(messages)
		current_dialogue+=1
	
	
	if Input.is_action_just_pressed("change") and can_change:
		
		can_change = false
		world =  (world + 1) % 2
		maps[world].tile_set.set("physics_layer_0/collision_layer", 17)
		if player.get_node("AntiClipingZone").has_overlapping_bodies():
			cant_change_world_sound.play()
			world =  (world + 1) % 2
			maps[world].tile_set.set("physics_layer_0/collision_layer", 17)
			if dialogue_clip==true:
				var d= dialogue.instantiate()
				d.messages = ["DO YOU WANT TO EAT THE EARTH OF THE OTHER PLANET?" ]
				add_child(d)
				dialogue_clip = false
		else:
			change_world_sound.play()
			if 	fondo_juego.visible == false:
				fondo_juego.visible = true
				parallax_background.visible =false 
				parallax_background_2.visible = false
			else:
				fondo_juego.visible = false
				parallax_background.visible =true 
				parallax_background_2.visible = true
			dialogue_clip= true

	maps[1].modulate.a = move_toward(maps[1].modulate.a,world,0.03)
	maps[0].modulate.a = move_toward(maps[0].modulate.a,(world+1)%2,0.03)
	
	if maps[(world + 1) % 2].modulate.a < 0.3:
		can_change = true
		maps[(world + 1) % 2].tile_set.set("physics_layer_0/collision_layer", 16)
		
	if player.global_position.y > botom+75:
		player.respawn()
