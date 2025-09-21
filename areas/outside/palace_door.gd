extends Node2D

@onready var actionable: Actionable = $Actionable

func _ready():
	actionable.on_action_ended.connect(go_inside_palace)

func go_inside_palace():
	GameManager.transition_to_scene(load("res://areas/outside/outside.tscn"))
