extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 2000
var GRAVITY = 1000
@onready var pivot = $Pivot
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")


func _ready():
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():

		if is_on_wall() and velocity.y>0:
			velocity.y += (GRAVITY * delta)/10
		else:
			velocity.y += GRAVITY * delta


	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION*delta)

	move_and_slide()
	
	# animations
	if is_on_floor():
		if abs(velocity.x) > 10 or direction:
			playback.travel("run")
		else:
			playback.travel("idle")
	elif is_on_wall():
		playback.travel("grab")
	else:
		if velocity.y<0:
			playback.travel("jump")
		else:
			playback.travel("fall")


	# direction
	if direction:
		pivot.scale.x = sign(direction)
		
	

	
