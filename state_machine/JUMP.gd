extends "state.gd"

@onready var animation_tree = $"../../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")
@onready var jump_sound = $"../../jump_sound"

func update(delta):
	Player.gravity(delta)
	
	jump_movement()
	player_movement()

	if Player.velocity.y > 0:
		return STATES.FALL
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
		
	
	
	return null

func enter_state():
	playback.travel("jump")
	jump_sound.play()
	Player.velocity.y = Player.JUMP_VELOCITY
	
	
func jump_movement():
	if !Player.jump_input:
		if Player.velocity.y < Player.min_jump_velocity:
			Player.velocity.y = Player.min_jump_velocity
