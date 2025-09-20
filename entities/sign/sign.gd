extends Node2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@onready var actionable = $Actionable

func _ready():
	actionable.dialogue_resource = dialogue_resource
	actionable.dialogue_start = dialogue_start
