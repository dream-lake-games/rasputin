extends CharacterBody2D

const MOVE_SPEED = 120.0

func _ready():
	velocity = Vector2.ZERO

	CameraManager.follow(self)

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed(InputActions.LEFT):
		input_vector.x -= 1
	if Input.is_action_pressed(InputActions.RIGHT):
		input_vector.x += 1
	if Input.is_action_pressed(InputActions.UP):
		input_vector.y -= 1
	if Input.is_action_pressed(InputActions.DOWN):
		input_vector.y += 1
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized() # Prevent diagonal speed boost
	
	velocity = input_vector * MOVE_SPEED
	
	move_and_slide()
