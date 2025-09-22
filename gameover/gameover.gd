extends Node2D

func _ready():
	process_priority = -1

func _unhandled_input(_event):
	if Input.is_action_just_pressed(InputActions.A) or Input.is_action_just_pressed("ui_accept"):
		if GameManager.last_scene_before_death:
			GameManager.transition_to_scene(GameManager.last_scene_before_death)
