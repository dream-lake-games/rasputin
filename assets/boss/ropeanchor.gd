extends Node2D

var broken = false
var break_frame = 0.0

func break_rope():
	break_frame = 0
	broken = true
	
func _process(delta):
	if broken:
		break_frame += delta * 60.0
		$Sprite2D.position.y = -62 - 0.2 * (break_frame * break_frame)
	else:
		$Sprite2D.position.y = -62
