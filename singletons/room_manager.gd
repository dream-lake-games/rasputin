extends Node

const TRANSITION_DURATION: float = 0.4

var driver_area: Area2D = null
var active_room: RoomMarker = null

func _ready():
	update_active_room()

func get_active_rect() -> Rect2:
	if active_room == null:
		return Rect2()
	var rect_shape = active_room.collision_shape.shape as RectangleShape2D
	return Rect2(active_room.collision_shape.position - rect_shape.size / 2.0, rect_shape.size)

func update_active_room():
	if driver_area == null:
		return

	var overlapping_areas = driver_area.get_overlapping_areas()

	if overlapping_areas.size() > 0:
		active_room = overlapping_areas[0]


func _physics_process(_delta):
	update_active_room()
