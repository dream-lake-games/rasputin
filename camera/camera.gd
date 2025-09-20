class_name Camera extends Camera2D

func _ready():
	GameManager.camera = self

func update_position():
	position = RoomManager.driver_area.global_position.round()
	var active_rect = RoomManager.get_active_rect()


	if active_rect == Rect2():
		return
	
	var view_port_size = get_viewport_rect().size

	var min_x = active_rect.position.x + view_port_size.x / 2.0
	var max_x = active_rect.position.x + active_rect.size.x - view_port_size.x / 2.0
	position.x = clamp(position.x, min_x, max_x)
	var min_y = active_rect.position.y + view_port_size.y / 2.0
	var max_y = active_rect.position.y + active_rect.size.y - view_port_size.y / 2.0
	position.y = clamp(position.y, min_y, max_y)

func _process(_delta):
	if RoomManager.driver_area != null:
		update_position()

	pass
