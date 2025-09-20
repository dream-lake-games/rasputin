extends Node2D

func _ready():
	DialogueManager.show_dialogue_balloon_scene(
		load("res://dialogue/balloon/balloon.tscn"),
		load("res://dialogue/outside/first_sign.dialogue"),
	)
