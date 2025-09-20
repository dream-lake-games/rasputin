extends Node

var camera: Camera = null
var is_transitioning_scenes: bool = false

func transition_to_scene(scene: PackedScene, dark_time: float = 0.5):
	if not is_transitioning_scenes:
		is_transitioning_scenes = true
		var main = get_node("/root/Main")
		assert(main != null, "uh oh")

		var step_time = 0.1

		await get_tree().create_timer(step_time).timeout
		ShaderDeltaManager.delta = 1
		await get_tree().create_timer(step_time).timeout
		ShaderDeltaManager.delta = 2
		await get_tree().create_timer(step_time).timeout
		ShaderDeltaManager.delta = 3
		await get_tree().create_timer(step_time).timeout

		await get_tree().create_timer(dark_time).timeout
		main._set_main_scene(scene)

		ShaderDeltaManager.delta = 2
		await get_tree().create_timer(step_time).timeout
		ShaderDeltaManager.delta = 1
		await get_tree().create_timer(step_time).timeout
		ShaderDeltaManager.delta = 0
		is_transitioning_scenes = false
