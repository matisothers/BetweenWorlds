extends "state.gd"

@onready var animation_tree = $"../../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")


func update(delta):
	Player.gravity(delta)
	if Player.movement_input.x != 0:
		return STATES.MOVE
		
	if Player.jump_input_actuation == true:
		return STATES.JUMP
		
	if Player.velocity.y > 0:
		return STATES.FALL
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
	
func enter_state():
	playback.travel("idle")
	Player.can_dash = true
	
