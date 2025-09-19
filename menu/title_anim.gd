extends Sprite2D

@onready var animation_player: AnimationPlayer = $animplayertitle

func _ready():
	animation_player.speed_scale = 0.5
	animation_player.play("flicker")
	animation_player.animation_finished.connect(keep_playing)

func keep_playing(_finished: StringName):
	animation_player.play("flicker")
