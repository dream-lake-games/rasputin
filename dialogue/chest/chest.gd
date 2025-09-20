extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var actionable: Node2D = $Actionable

func _ready():
	actionable.on_action_started.connect(on_action_started)
	actionable.on_action_ended.connect(on_action_ended)

func on_action_started():
	animation_player.play("open")

func on_action_ended():
	animation_player.play("close")

func on_animation_finished(finished: StringName):
	match finished:
		"open":
			animation_player.play("opened")
		"close":
			animation_player.play("closed")
		_:
			animation_player.play(finished)
