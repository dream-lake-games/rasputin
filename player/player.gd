extends CharacterBody2D

const MOVE_SPEED = 120.0

@onready var room_collision_area: Area2D = $RoomCollisionArea

func _ready():
	velocity = Vector2.ZERO
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

		var player_shape: RectangleShape2D = room_collision_area.shape_owner_get_shape(0, 0) as RectangleShape2D
		var room_shape: RectangleShape2D = area.shape_owner_get_shape(0, 0) as RectangleShape2D
		
		var player_rect: Rect2 = Rect2(
			room_collision_area.global_position,
			player_shape.size * 2
		)
		var room_rect: Rect2 = Rect2(
			area.global_position,
			room_shape.size * 2
		)
		
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
