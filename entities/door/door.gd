class_name Door extends Node2D

@export var door_group: StringName

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("closed")
	animation_player.animation_finished.connect(on_animation_finished)

func open():
	animation_player.play("opening")

func on_animation_finished(finished: StringName):
	match finished:
		"opening": animation_player.play("open")
		_: animation_player.play(finished)
