extends "state.gd"

@onready var animation_tree = $"../../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.get_next_to_wall() != null:
		return STATES.SLIDE
	if Player.velocity.y > 0:
		return STATES.FALL
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
		
	
	
	return null

func enter_state():
	playback.travel("jump")
	Player.velocity.y = Player.JUMP_VELOCITY
	
	
