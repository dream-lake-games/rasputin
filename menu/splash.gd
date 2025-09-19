extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	await get_tree().create_timer(0.3).timeout
	animation_player.play("splash")
	await animation_player.animation_finished
	GameManager.transition_to_scene(load("res://menu/title.tscn"))
