extends Node

const TRANSITION_DURATION: float = 0.4

var current_room: Node2D = null
var is_transitioning: bool = false

func _get_room_bounds(room: Node2D) -> Rect2:
	assert(room.is_in_group("rooms"), "Node must be in 'rooms' group")
	var collision_shape: CollisionShape2D = room.get_node("Bounds/CollisionShape2D") as CollisionShape2D
	assert(collision_shape != null, "Room must have Bounds/CollisionShape2D")
	var rect_shape: RectangleShape2D = collision_shape.shape as RectangleShape2D
	assert(rect_shape != null, "CollisionShape2D must have RectangleShape2D")
	return Rect2(room.global_position, rect_shape.size)

func _enter_room(node: Node2D) -> void:
	var new_bounds: Rect2 = _get_room_bounds(node)
	
	if current_room == null:
		CameraManager.set_bounds(new_bounds)
		current_room = node
		return
	
	_transition_to_room(node, new_bounds)

func _transition_to_room(node: Node2D, new_bounds: Rect2) -> void:
	if is_transitioning:
		return
		
	is_transitioning = true
	var start_bounds: Rect2 = _get_room_bounds(current_room)
	current_room = node
	
	Engine.time_scale = 0.0
	var start_time = Time.get_ticks_msec() / 1000.0
	
	while true:
		await get_tree().process_frame
		var current_time = Time.get_ticks_msec() / 1000.0
		var elapsed = current_time - start_time
		var t: float = min(elapsed / TRANSITION_DURATION, 1.0)
		var eased_t: float = ease(t, -1.5)
		var current_bounds := Rect2()
		current_bounds.position = start_bounds.position.lerp(new_bounds.position, eased_t)
		current_bounds.size = start_bounds.size.lerp(new_bounds.size, eased_t)
		CameraManager.set_bounds(current_bounds)
		if elapsed >= TRANSITION_DURATION:
			break
	
	CameraManager.set_bounds(new_bounds)
	Engine.time_scale = 1.0
	is_transitioning = false

func mark_player_in_room(node: Node2D) -> void:
	if is_transitioning:
		return
	if node == current_room:
		return
	_enter_room(node)
