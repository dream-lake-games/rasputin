class_name Fireball extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var velocity: Vector2 = Vector2.ZERO
var lifetime: float = 12.0

func _ready():
	animation_player.play("flicker")
	self.body_entered.connect(_on_body_entered)

func set_velocity(new_velocity: Vector2):
	velocity = new_velocity

func _physics_process(delta):
	position += velocity * delta

	rotation += 2.0 * TAU * delta

	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_body_entered(body):
	if body.has_method("get_hurt"):
		body.get_hurt()

	queue_free()
