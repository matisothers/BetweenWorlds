extends "state.gd"

@onready var animation_tree = $"../../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x == 0:
		return STATES.IDLE
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.activate_jump:
		return STATES.JUMP
		
	if Player.dash_input:
		return STATES.DASH
	return null

func enter_state():
	playback.travel("run")
	Player.can_dash = true
