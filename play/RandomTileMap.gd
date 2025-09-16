extends TileMapLayer
class_name RandomTileMap

## This script allows you to place random tile variations
## Each tile "type" can have multiple visual variants

# Define your tile variations here
# Each key is a "tile type", each value is an array of atlas coordinates
var tile_variations = {
	"floor": [
		Vector2i(0, 0), # Floor texture 1
		Vector2i(1, 0), # Floor texture 2
		Vector2i(2, 0), # Floor texture 3
		Vector2i(3, 0), # Floor texture 4
		Vector2i(4, 0), # Floor texture 5
	],
	"wall": [
		Vector2i(0, 1), # Wall variant 1
		Vector2i(1, 1), # Wall variant 2
		Vector2i(2, 1), # Wall variant 3
		Vector2i(3, 1), # Wall variant 4
	]
}

# Optional: weighted variations for non-uniform distribution
var weighted_variations = {
	"floor": [
		{"coord": Vector2i(0, 0), "weight": 40}, # 40% chance
		{"coord": Vector2i(1, 0), "weight": 25}, # 25% chance
		{"coord": Vector2i(2, 0), "weight": 20}, # 20% chance
		{"coord": Vector2i(3, 0), "weight": 10}, # 10% chance
		{"coord": Vector2i(4, 0), "weight": 5}, # 5% chance
	]
}

## Place a random tile of the specified type at the given position
func place_random_tile(tile_type: String, cell_position: Vector2i, use_weights: bool = false):
	if use_weights and tile_type in weighted_variations:
		var coord = _get_weighted_random_tile(weighted_variations[tile_type])
		set_cell(cell_position, 0, coord) # 0 is the source_id
	elif tile_type in tile_variations:
		var coord = tile_variations[tile_type].pick_random()
		set_cell(cell_position, 0, coord)
	else:
		push_error("Unknown tile type: " + tile_type)

## Fill an area with random tiles of the specified type
func fill_area_random(tile_type: String, start: Vector2i, end: Vector2i, use_weights: bool = false):
	for x in range(start.x, end.x + 1):
		for y in range(start.y, end.y + 1):
			place_random_tile(tile_type, Vector2i(x, y), use_weights)

## Replace all tiles of a specific atlas coordinate with random variations
func randomize_existing_tiles(original_coord: Vector2i, tile_type: String):
	var cells = get_used_cells()
	for cell in cells:
		var atlas_coord = get_cell_atlas_coords(cell)
		if atlas_coord == original_coord:
			place_random_tile(tile_type, cell)

## Helper function for weighted random selection
func _get_weighted_random_tile(tiles_array: Array) -> Vector2i:
	var total_weight = 0
	for tile in tiles_array:
		total_weight += tile.weight
	
	var random_value = randf() * total_weight
	var current_weight = 0
	
	for tile in tiles_array:
		current_weight += tile.weight
		if random_value <= current_weight:
			return tile.coord
	
	return tiles_array[-1].coord # Fallback

## Example: Create a custom painting tool
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_key_pressed(KEY_SHIFT): # Hold Shift to paint random floor tiles
			var mouse_pos = get_global_mouse_position()
			var cell_pos = local_to_map(to_local(mouse_pos))
			place_random_tile("floor", cell_pos, true) # Use weighted random
