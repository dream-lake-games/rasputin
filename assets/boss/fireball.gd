extends Node2D

var movement_vector = Vector2(1,0)
var f = 0
var underlying_pos
const size = 8



func start(start_pos, player_pos):
	underlying_pos = start_pos
	movement_vector = (player_pos - underlying_pos).normalized()
	position = start_pos

func _process(delta):
	f += delta * 60.0
	$Sprite2D.rotation = int(f / 10.0) % 4 * (PI / 2)
	$Sprite2D.frame = int(f / 5.0) % 2
	underlying_pos += movement_vector * delta * 72
	position = round(underlying_pos)
	
	var player = get_parent().get_node("Player")
	var player_pos = player.position
	if abs(player_pos.x - position.x) < size and abs(player_pos.y - position.y) < size:
		player.get_hurt()
	
