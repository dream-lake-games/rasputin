extends Camera2D

func _ready():
	pass

func _physics_process(_delta):
	if CameraManager._following == null:
		return
	self.position = CameraManager._following.position

func _process(_delta):
	if CameraManager._bounds == Rect2():
		return
	self.limit_left = int(CameraManager._bounds.position.x)
	self.limit_top = int(CameraManager._bounds.position.y)
	self.limit_right = int(CameraManager._bounds.position.x + CameraManager._bounds.size.x)
	self.limit_bottom = int(CameraManager._bounds.position.y + CameraManager._bounds.size.y)
