class_name FireSpitter extends Node2D

@export var cycle: int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var fireball_tscn = preload("res://entities/fireball/fireball.tscn")

func _ready():
	animation_player.animation_finished.connect(on_animation_finished)
	animation_player.play("fire")
	
	var animation_length = animation_player.get_animation("fire").length
	var offset = (0.9999 - (cycle % 12) / 12.0) * animation_length
	animation_player.seek(offset, true)
	

func on_animation_finished(finished: StringName):
	animation_player.play(finished)

	var fireball: Fireball = fireball_tscn.instantiate()
	
	var adjusted_rotation = rotation - PI / 2
	var direction = Vector2.from_angle(adjusted_rotation)
	
	get_parent().add_child(fireball)
	
	fireball.global_position = global_position + direction * 11
	
	fireball.set_velocity(direction * 75)