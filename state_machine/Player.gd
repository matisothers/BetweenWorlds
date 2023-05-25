extends CharacterBody2D




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = 1000

#input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false
var activate_jump = false

#Jump_stats
var tile_size = 8
var MAX_JUMP_HEIGHT = tile_size*7+ 0.35
var MIN_JUMP_HEIGHT = tile_size*2 + 0.35
var jump_duration = .3
var max_jump_velocity = 0
var min_jump_velocity = 0

#Movimiento del player
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 3000
var last_direction = Vector2.RIGHT
#Estados/States
var current_state = null
var previous_state = null
#Mecanicas
var can_dash = true
#dialogues
var dialogue = preload("res://dialogos.tscn")
#jugador 
@onready var player = $"."

#Nodos
@onready var STATES = $STATES
@onready var RayCasts = $raycasts
@onready var pivot = $Pivot
@onready var camera = $Camera2D
@onready var pre_jump_window_timer = $Timers/PreJumpWindowTimer

var dialogue_1 = true
var dialogue_2 = true
var dialogue_3 = true
var dialogue_4 = true
func _ready():

	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	
	current_state = STATES.IDLE
	previous_state = STATES.IDLE
	set_velocity_values()
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	#default_move(delta)
	pivot.scale.x = last_direction.x
	

	$LABEL.text = str(current_state.get_name(), player.position.x)
	move_and_slide()
	
	if (player.position.x >=250 and dialogue_1==true):
		var d= dialogue.instantiate()
		d.messages = ["HEYY YOU", "YES YOU", "who I am?", "I'm Jesus", "nah kidding", "I'm the 44 president Barack Obama",
		"press space to jump", "not sure what space is but press it"]
		add_child(d)
		dialogue_1=false
	if (player.position.x >=520 and dialogue_2==true):
		var d= dialogue.instantiate()
		d.messages = [ "That looks kinda far","you can change the world you are", "just press X", "this platform is special", "it is in
		both worlds"]
		add_child(d)
		dialogue_2=false
	if (player.position.x >=750 and dialogue_3==true):
		var d= dialogue.instantiate()
		d.messages = [ "JUMPP AND SWITCH WORLDSSSS"]
		add_child(d)
		dialogue_3=false
	if (player.position.x >=1100 and dialogue_4==true):
		var d= dialogue.instantiate()
		d.messages = [ "Try to complete the level", "the blood moon is rising once again"]
		add_child(d)
		dialogue_4=false
	

	
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
		
func set_velocity_values():
	gravity_value = 2 * MAX_JUMP_HEIGHT / pow(jump_duration,2)
	max_jump_velocity = -sqrt(2*gravity_value*MAX_JUMP_HEIGHT)
	min_jump_velocity = -sqrt(2*gravity_value*MIN_JUMP_HEIGHT)


func change_state(input_state):
	if input_state != null:
		previous_state = current_state
		current_state = input_state
		
		previous_state.exit_state()
		current_state.enter_state()
		
func player_input():
	movement_input = Vector2.ZERO
	
	#Movimiento
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
		
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
		
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
		
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
		
		
	#Salto	
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else:
		jump_input = false
		
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
		
	#Trepar
	if Input.is_action_pressed("Climb"):
		climb_input = true
	else:
		climb_input = false
		
	#Dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else:
		dash_input = false
	jump_logic()


func get_next_to_wall():
	for raycast in RayCasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null
	
func set_camera_limits(sup_izq:Vector2, inf_der:Vector2):
	camera.limit_bottom = inf_der.y
	camera.limit_left= sup_izq.x
	camera.limit_right= inf_der.x
	camera.limit_top= sup_izq.y
	
func jump_logic():
	if jump_input_actuation:
		activate_jump = true
		pre_jump_window_timer.start()

	
	


func _on_pre_jump_window_timer_timeout():
	activate_jump = false
