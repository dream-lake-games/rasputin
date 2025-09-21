extends Node2D

var boss_alive = true
var f = 0
var last_fireball_f = 0

var fireball_scene = preload("res://assets/boss/fireball.tscn")

func _process(delta):
	if boss_alive:
		f += delta
	
	if f > last_fireball_f + 1.2:
		last_fireball_f = f
		spawn_fireball()
		
		
func spawn_fireball():
	var fireball = fireball_scene.instantiate()
	add_child(fireball)
	var player_pos = get_node("Player").position
	fireball.start(player_pos)
