extends Sprite2D

var falling = false
var fall_frame = 0.0

func start_falling():
	fall_frame = 0
	falling = true
	
func _process(delta):
	if falling:
		fall_frame += delta * 60.0
		position.y = -24 + 0.2 * (fall_frame * fall_frame)
		if position.y > 40:
			position.y = 40
	else:
		position.y = -24
