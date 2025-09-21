extends Node2D

@onready var actionable: Actionable = $Actionable

func _ready():
	actionable.on_action_ended.connect(queue_free)

func destroy():
	print("mork - destroyed...")
	queue_free()
