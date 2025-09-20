class_name RoomMarker extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func is_active():
	RoomManager.active_area = self

func get_rect():
	var node = get_node("CollisionShape2D")
	assert(node != null, "room_marker must have CollisionsShape2D")
