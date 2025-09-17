extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

signal on_action_started()
signal on_action_ended()

func action():
	on_action_started.emit()
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	await DialogueManager.dialogue_ended
	on_action_ended.emit()
