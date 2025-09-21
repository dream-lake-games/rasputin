extends Node

@onready var detail_tile_map: TileMapLayer = $"../DetailTileMap"

# Preload entity scenes
const FIRE_SPITTER_SCENE = preload("res://entities/fire_spitter/fire_spitter.tscn")

func _ready():
	var used_cells = detail_tile_map.get_used_cells()
	
	for cell_pos in used_cells:
		var tile_data: TileData = detail_tile_map.get_cell_tile_data(cell_pos)
		var alternative_id = detail_tile_map.get_cell_alternative_tile(cell_pos)
		if tile_data == null:
			continue
		var entity = tile_data.get_custom_data("Entity")
		if entity != "":
			var flip_h = (alternative_id & TileSetAtlasSource.TRANSFORM_FLIP_H) != 0
			var flip_v = (alternative_id & TileSetAtlasSource.TRANSFORM_FLIP_V) != 0
			var transpose = (alternative_id & TileSetAtlasSource.TRANSFORM_TRANSPOSE) != 0

			var rotation_degrees = 0
			if transpose and flip_h and not flip_v:
				rotation_degrees = 90
			elif flip_h and flip_v and not transpose:
				rotation_degrees = 180
			elif transpose and flip_v and not flip_h:
				rotation_degrees = 270

			var local_pos = detail_tile_map.map_to_local(cell_pos)
			
			match entity:
				"FireSpitter":
					var fire_spitter = FIRE_SPITTER_SCENE.instantiate()
					fire_spitter.position = local_pos
					fire_spitter.rotation_degrees = rotation_degrees
					add_child(fire_spitter)
