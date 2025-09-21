class_name Actionable
extends Area2D

@export var dialogue_resource: DialogueResource = null
@export var dialogue_start: String = "start"

signal on_action_started()
signal on_action_ended()

func action():
	on_action_started.emit()
	if dialogue_resource != null:
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start, GameManager.dialogue_states)
		await DialogueManager.dialogue_ended
	on_action_ended.emit()
