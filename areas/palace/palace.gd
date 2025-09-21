class_name Palace extends Node2D

class PalaceState:
	var has_had_intro_chat_with_rasputin: bool = false
	var has_had_intro_rug_chat: bool = false
	var num_rugs_seen: int = 0
	var has_answered_rug_riddle: bool = false
	var has_acquired_poison: bool = false
	var has_acquired_cake: bool = false
	var has_seen_useless_chest: bool = false

	var doors: Array[Door] = []
	func open_doors(door_group: StringName):
		for door in self.doors:
			if door.door_group == door_group:
				door.open()

var state: PalaceState = PalaceState.new()

var doors: Array[Door] = []

func _ready():
	GameManager.add_dialogue_state(state)
	for child in self.find_children("*", "Door", true, true):
		if child is Door:
			self.state.doors.append(child)
	
	# state.has_had_intro_chat_with_rasputin = true
	# state.has_had_intro_rug_chat = true
	# state.num_rugs_seen = 8
	# state.has_answered_rug_riddle = true
	# state.has_acquired_poison = true
	# state.has_acquired_cake = true
	# state.has_seen_useless_chest = true
