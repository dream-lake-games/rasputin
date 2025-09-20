@tool
extends Node2D

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var bounds: Area2D = $Bounds
@onready var bounds_shape: CollisionShape2D = $Bounds/CollisionShape2D

func _ready():
	set_process(true)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_bounds()

func update_bounds():
	var used_rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size.x
	var new_bounds_shape = RectangleShape2D.new()
	new_bounds_shape.size = used_rect.size * tile_size
	bounds_shape.shape = new_bounds_shape
	bounds_shape.position = used_rect.get_center() * tile_size
	if used_rect.size.x % 2 == 1:
		bounds_shape.position.x += tile_size / 2.0
	if used_rect.size.y % 2 == 1:
		bounds_shape.position.y += tile_size / 2.0
