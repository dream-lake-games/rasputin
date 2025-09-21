extends Node2D

func _unhandled_input(_e) -> void:
	if Input.is_action_just_pressed(InputActions.START):
		GameManager.transition_to_scene(load("res://areas/outside/outside.tscn"))
