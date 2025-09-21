extends Node2D

var start_pos = Vector2(0, 0)
var movement_vector = Vector2(1,0)
var f = 0
var underlying_pos = start_pos

func start(player_pos):
	underlying_pos = start_pos
	movement_vector = (player_pos - underlying_pos).normalized()

func _process(delta):
	f += delta * 60.0
	$Sprite2D.rotation = int(f / 10.0) % 4 * (PI / 2)
	$Sprite2D.frame = int(f / 5.0) % 2
	underlying_pos += movement_vector * delta * 48
	position = round(underlying_pos)
	
