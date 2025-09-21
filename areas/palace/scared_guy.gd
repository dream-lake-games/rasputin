extends Node2D

func _ready():
	$AnimationPlayer.play("yell")
	$AnimationPlayer.animation_finished.connect(loop)

func loop(_finished):
	$AnimationPlayer.play("yell")
