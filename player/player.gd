extends CharacterBody2D

const MOVE_SPEED = 120.0

@onready var room_collision_area: Area2D = $RoomCollisionArea

func _ready():
	velocity = Vector2.ZERO
	print("okay now wth")
	CameraManager.follow(self)

func handle_input():
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

func update_room():
	var biggest_area = 0
	var winning_node: Node2D = null

	for area in room_collision_area.get_overlapping_areas():
		var parent = area.get_parent() as Node2D
		if !parent.is_in_group("rooms"):
			continue

		var player_shape = room_collision_area.shape_owner_get_shape(0, 0) as RectangleShape2D
		var player_rect = player_shape.get_rect()
		var room_shape = area.shape_owner_get_shape(0, 0) as RectangleShape2D
		var room_rect = room_shape.get_rect()

		@warning_ignore("unsafe_call_argument")
		var intersection = player_rect.intersection(room_rect)
		var overlap_area = intersection.get_area()
		if overlap_area > biggest_area:
			biggest_area = overlap_area
			winning_node = parent

	if winning_node != null:
		GameManager.mark_player_in_room(winning_node)


func _physics_process(_delta):
	handle_input()
	update_room()

	move_and_slide()


func _process(_delta):
	pass
