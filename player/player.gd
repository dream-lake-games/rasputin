extends CharacterBody2D

@onready var room_collision_area: Area2D = $RoomCollisionArea
@onready var actionable_marker: Marker2D = $ActionableMarker
@onready var actionable_area: Area2D = $ActionableMarker/Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var actionable_indicator_animation_player: AnimationPlayer = $ActionableIndicator/AnimationPlayer

const MOVE_SPEED = 86.0

var input_vector: Vector2 = Vector2.ZERO
var show_actioning_indicator: bool = true
var BOSS_BATTLE = true

enum Facing {
	Left,
	Right,
	Up,
	Down,
}
var facing: Facing = Facing.Down


func _ready():
	RoomManager.driver_area = room_collision_area

	velocity = Vector2.ZERO
	animation_player.animation_finished.connect(on_animation_finished)
	actionable_indicator_animation_player.animation_finished.connect(on_actionable_indicator_animation_finished)
	process_priority = -1

func _exit_tree() -> void:
	if RoomManager.driver_area == room_collision_area:
		RoomManager.driver_area = null

func _unhandled_input(_event):
	var new_input_vector = Vector2.ZERO

	if GameManager.is_transitioning_scenes:
		input_vector = new_input_vector
		return

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

	if Input.is_action_just_pressed(InputActions.A):
		var actionables = actionable_area.get_overlapping_areas()
		if actionables.size() > 0:
			show_actioning_indicator = false
			await actionables[0].action()
			show_actioning_indicator = true
			
	if Input.is_action_just_pressed(InputActions.A):
		if BOSS_BATTLE:
			check_for_ropes()

func handle_facing():
	match facing:
		Facing.Down:
			actionable_marker.rotation_degrees = 180
		Facing.Up:
			actionable_marker.rotation_degrees = 0
		Facing.Left:
			actionable_marker.rotation_degrees = -90
			sprite.flip_h = false
		Facing.Right:
			actionable_marker.rotation_degrees = 90
			sprite.flip_h = true

func update_animation():
	if velocity.length() > 0:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		animation_player.play("idle")

func update_actionable_indicator():
	if actionable_area.has_overlapping_areas() and show_actioning_indicator:
		actionable_indicator_animation_player.play("A")
	else:
		actionable_indicator_animation_player.play("none")

func _physics_process(_delta):
	velocity = input_vector * MOVE_SPEED
	handle_facing()
	update_actionable_indicator()

	move_and_slide()
	update_animation()


func on_animation_finished(finished: StringName):
	match finished:
		_:
			animation_player.play(finished)

func on_actionable_indicator_animation_finished(finished: StringName):
	actionable_indicator_animation_player.play(finished)


func _process(_delta):
	pass
	
	
func check_for_ropes():
	var num_broken = 0
	
	for i in range(4):
		var ropeanchor = get_parent().get_node("Ropeanchor" + str(i+1))
		if not ropeanchor.broken:
			if abs(ropeanchor.position.x - position.x) < 16 and abs(ropeanchor.position.y - position.y) < 16:
				ropeanchor.break_rope()
				num_broken += 1
		else:
			num_broken += 1
	
	if num_broken == 4:
		start_piano_fall()
		
		
func start_piano_fall():
	for i in range(4):
		get_parent().get_node("Rope" + str(i + 1)).visible = false
	get_parent().get_node("Piano").start_falling()
		
