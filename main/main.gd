class_name Main
extends Node2D

@onready var subviewport: SubViewport = $SubViewportContainer/SubViewport
@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect

func _ready():
	# We need this so the dialogue manager renders in the subviewport and has color
	# quantization happening correctly
	DialogueManager.get_current_scene = func(): return subviewport
	DMSettings.set_setting(DMSettings.BALLOON_PATH, "res://dialogue/balloon/balloon.tscn")

	# GameManager.transition_to_scene(load("res://menu/splash.tscn"))
	GameManager.transition_to_scene(load("res://areas/outside/outside.tscn"))
	# GameManager.transition_to_scene(load("res://rooms/palace.tscn"))

func _process(delta):
	texture_rect.material.set_shader_parameter("delta", ShaderDeltaManager.delta)

func _set_main_scene(scene: PackedScene):
	for n in subviewport.get_children():
		subviewport.remove_child(n)
		n.queue_free()
	subviewport.add_child(scene.instantiate())
