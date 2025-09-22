extends Area2D

@onready var palace: Palace = owner

var has_been_seen = false

func _physics_process(_delta) -> void:
	if not palace.state.has_had_intro_rug_chat or has_been_seen:
		return
		
	if self.has_overlapping_bodies():
		palace.state.num_rugs_seen += 1
		has_been_seen = true
		print("saw it!")