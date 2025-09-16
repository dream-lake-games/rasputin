extends TileMapLayer

## Simple script to add to your TileMapLayer for random tile variations
## This preserves all your Better Terrain rules while randomizing visuals

@export var enable_random_variations: bool = true
@export var randomize_on_ready: bool = false

# Define floor variations (all should have the same Better Terrain metadata)
var floor_tiles = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0), Vector2i(4, 0)]

# Define wall variations
var wall_tiles = [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]

func _ready():
	if randomize_on_ready:
		randomize_existing_tiles()

## Call this to randomize all existing tiles
func randomize_existing_tiles():
	var cells = get_used_cells()
	
	for cell in cells:
		var current_coord = get_cell_atlas_coords(cell)
		var new_coord = get_random_variant(current_coord)
		
		if new_coord != current_coord:
			set_cell(cell, 0, new_coord)

## Get a random variant that matches the same tile "type"
func get_random_variant(atlas_coord: Vector2i) -> Vector2i:
	if not enable_random_variations:
		return atlas_coord
	
	# Check if it's a floor tile
	if atlas_coord in floor_tiles:
		return floor_tiles.pick_random()
	
	# Check if it's a wall tile
	elif atlas_coord in wall_tiles:
		return wall_tiles.pick_random()
	
	# Return original if no variants defined
	return atlas_coord

## Override set_cell to automatically randomize when placing tiles
func set_cell_with_random(coords: Vector2i, source_id: int = 0, atlas_coords: Vector2i = Vector2i(-1, -1), alternative_tile: int = 0):
	if enable_random_variations and atlas_coords != Vector2i(-1, -1):
		atlas_coords = get_random_variant(atlas_coords)
	
	set_cell(coords, source_id, atlas_coords, alternative_tile)

## Helper to place a random floor tile
func place_random_floor(cell_position: Vector2i):
	set_cell(cell_position, 0, floor_tiles.pick_random())

## Helper to place a random wall tile
func place_random_wall(cell_position: Vector2i):
	set_cell(cell_position, 0, wall_tiles.pick_random())
