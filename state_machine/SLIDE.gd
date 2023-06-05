extends "state.gd"

@onready var animation_tree = $"../../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")
@export var climb_speed = 80
@export var slide_friction = -10

func update(delta):
	
	slide_movement(delta)
	if Player.get_next_to_wall() == null:
		return STATES.FALL
	if Player.activate_jump:
		return STATES.JUMP
	if Player.is_on_floor():
		return STATES.IDLE
		
	return null
	
func slide_movement(delta):
	if Player.climb_input:
		playback.travel("grab")
		if Player.movement_input.y < 0:
			Player.velocity.y = -climb_speed
		elif  Player.movement_input.y > 0:
			Player.velocity.y = climb_speed
			
		else:
			Player.velocity.y = 0
	else:
		player_movement()
		Player.gravity(delta)
		
		Player.velocity.y += slide_friction
