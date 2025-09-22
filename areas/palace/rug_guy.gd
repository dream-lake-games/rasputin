extends Sprite2D

@onready var palace: Palace = owner
@onready var static_body: StaticBody2D = $StaticBody2D
@onready var coll_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _process(_delta):
	if palace.state.has_answered_rug_riddle:
		static_body.set_deferred("disabled", true)
		coll_shape.disabled = true