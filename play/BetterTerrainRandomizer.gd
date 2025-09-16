extends Node
class_name BetterTerrainRandomizer

## This script works with Better Terrain to randomize tiles
## while preserving terrain rules

# Reference to your TileMapLayer
@export var tilemap_layer: TileMapLayer

# Define which tiles belong to the same "visual group"
# but should maintain the same terrain rules
var terrain_visual_groups = {
	"floor_variants": {
		"terrain_type": 2, # The terrain type from Better Terrain
		"tiles": [
			Vector2i(0, 0),
			Vector2i(1, 0),
			Vector2i(2, 0),
			Vector2i(3, 0),
			Vector2i(4, 0)
		]
	},
	"wall_variants": {
		"terrain_type": 3, # The terrain type from Better Terrain
		"tiles": [
			Vector2i(0, 1),
			Vector2i(1, 1),
			Vector2i(2, 1),
			Vector2i(3, 1)
		]
	}
}

## Randomize all tiles in the tilemap while preserving terrain rules
func randomize_all_tiles():
	if not tilemap_layer:
		push_error("No tilemap layer assigned!")
		return
	
	var cells = tilemap_layer.get_used_cells()
	
	for cell in cells:
		var current_atlas_coord = tilemap_layer.get_cell_atlas_coords(cell)
		var new_coord = _get_random_variant_for_tile(current_atlas_coord)
		
		if new_coord != Vector2i(-1, -1):
			tilemap_layer.set_cell(cell, 0, new_coord)

## Get a random variant for a tile while preserving its terrain type
func _get_random_variant_for_tile(atlas_coord: Vector2i) -> Vector2i:
	for group_name in terrain_visual_groups:
		var group = terrain_visual_groups[group_name]
		if atlas_coord in group.tiles:
			return group.tiles.pick_random()
	
	# If tile isn't in any group, return the original
	return atlas_coord

## Apply randomization when placing tiles with Better Terrain
func _ready():
	# You can connect this to Better Terrain's signals or call it manually
	# after using Better Terrain tools
	pass

## Example function to randomize tiles after Better Terrain placement
func on_better_terrain_placed():
	# Small delay to ensure Better Terrain has finished
	await get_tree().create_timer(0.1).timeout
	randomize_all_tiles()
