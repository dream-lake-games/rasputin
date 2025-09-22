extends Node2D

var boss_alive = true
var f = 0
var last_fireball_f = 0
var has_shown_defeat_dialogue = false
var dialogue_active = false

var fireball_scene = preload("res://assets/boss/fireball.tscn")

func _ready():
	get_node("Player").BOSS_BATTLE = true
	dialogue_active = true
	DialogueManager.show_dialogue_balloon(load("res://dialogue/boss/boss.dialogue"), "boss_intro")
	await DialogueManager.dialogue_ended
	dialogue_active = false

func _process(delta):
	if dialogue_active:
		return
		
	if boss_alive:
		f += delta
	
	if f > last_fireball_f + 1.2:
		last_fireball_f = f
		spawn_fireball()
		
	move_rasputin()
		
func spawn_fireball():
	var fireball = fireball_scene.instantiate()
	add_child(fireball)
	var player_pos = get_node("Player").position
	var rasp_pos = get_node("Rasputin").position
	fireball.start(rasp_pos, player_pos)

func move_rasputin():
	var rasp = get_node("Rasputin")
	var player = get_node("Player")
	if boss_alive:
		var delta = Vector2(0, 0)
		if player.position.x < rasp.position.x and rasp.position.x > -10:
			delta.x = -1
		if player.position.y < rasp.position.y and rasp.position.y > -10:
			delta.y = -1
		if player.position.x > rasp.position.x and rasp.position.x < 10:
			delta.x = 1
		if player.position.y > rasp.position.y and rasp.position.y < 10:
			delta.y = 1
		rasp.position += delta * 0.1
	else:
		rasp.position -= Vector2(8, 0)
		rasp.position *= 0.5
		rasp.position += Vector2(8, 0)
		if not has_shown_defeat_dialogue:
			has_shown_defeat_dialogue = true
			await get_tree().create_timer(2.0).timeout
			DialogueManager.show_dialogue_balloon(load("res://dialogue/boss/boss.dialogue"), "boss_defeated")
			await DialogueManager.dialogue_ended
			GameManager.transition_to_scene(load("res://gameover/gamewin.tscn"))
