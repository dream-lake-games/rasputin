class_name Main
extends Node2D

@onready var subviewport: SubViewport = $SubViewport
@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect

func _ready():
	GameManager.transition_to_scene(load("res://menu/splash.tscn"))

func _process(delta):
	texture_rect.material.set_shader_parameter("delta", ShaderDeltaManager.delta)

func _set_main_scene(scene: PackedScene):
	for n in subviewport.get_children():
		subviewport.remove_child(n)
		n.queue_free()
	subviewport.add_child(scene.instantiate())
