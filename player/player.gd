extends CharacterBody2D

@onready var room_collision_area: Area2D = $RoomCollisionArea
@onready var actionable_marker: Marker2D = $ActionableMarker
@onready var actionable_area: Area2D = $ActionableMarker/Area2D
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var sprite: Sprite2D = $Animation/Sprite2D

const MOVE_SPEED = 80.0

var input_vector: Vector2 = Vector2.ZERO

#  TODO(probably): Make this derived from some anim state...
enum Facing {
	Left,
	Right,
	Up,
	Down,
}
var facing: Facing = Facing.Down

func _ready():
	velocity = Vector2.ZERO
	CameraManager.follow(self)
	animation_player.animation_finished.connect(on_animation_finished)

func _unhandled_input(_event):
	var new_input_vector = Vector2.ZERO

	if Input.is_action_pressed(InputActions.LEFT):
		new_input_vector.x -= 1
	if Input.is_action_pressed(InputActions.RIGHT):
		new_input_vector.x += 1
	if Input.is_action_pressed(InputActions.UP):
		new_input_vector.y -= 1
	if Input.is_action_pressed(InputActions.DOWN):
		new_input_vector.y += 1

	if new_input_vector.length() > 0:
		new_input_vector = new_input_vector.normalized()
		
		if abs(new_input_vector.x) > 0:
			if new_input_vector.x < 0:
				facing = Facing.Left
			else:
				facing = Facing.Right
		elif abs(new_input_vector.y) > 0:
			if new_input_vector.y < 0:
				facing = Facing.Up
			else:
				facing = Facing.Down

	input_vector = new_input_vector

	if Input.is_action_just_pressed(InputActions.START):
		var actionables = actionable_area.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()

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

func handle_facing():
	match facing:
		Facing.Down:
			actionable_marker.rotation_degrees = 0
		Facing.Up:
			actionable_marker.rotation_degrees = 180
		Facing.Left:
			actionable_marker.rotation_degrees = 90
			sprite.flip_h = false
		Facing.Right:
			actionable_marker.rotation_degrees = -90
			sprite.flip_h = true

func update_animation():
	if velocity.length() > 0:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		animation_player.play("idle")

func _physics_process(_delta):
	velocity = input_vector * MOVE_SPEED
	update_room()
	handle_facing()

	move_and_slide()
	update_animation()


func on_animation_finished(finished: StringName):
	match finished:
		_:
			animation_player.play(finished)


func _process(_delta):
	pass
