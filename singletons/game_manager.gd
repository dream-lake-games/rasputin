extends Node

var camera: Camera = null
var is_transitioning_scenes: bool = false

var dialogue_states: Array[Variant] = []
var last_scene_before_death: PackedScene = null

func transition_to_scene(scene: PackedScene, dark_time: float = 0.5):
	dialogue_states.clear()
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

func add_dialogue_state(state: Variant):
	if not dialogue_states.has(state):
		dialogue_states.append(state)
