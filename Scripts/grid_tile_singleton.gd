extends Node

var gridTileScene: PackedScene = preload("res://Scenes/GridTile.tscn")

# Store all tiles in a dictionary
var tiles = {}

func _ready() -> void:
	load_tiles_from_folder("res://gridTileJSONS/")

func load_tiles_from_folder(folder_path: String) -> void:
	var dir = DirAccess.open(folder_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			if file_name.ends_with(".json"):
				load_tile_from_file(folder_path + file_name)
			file_name = dir.get_next()

		dir.list_dir_end()
	else:
		print("Failed to open directory:", folder_path)

func load_tile_from_file(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var data = file.get_as_text()
		file.close() # Close the file after reading

		# Create an instance of JSON and parse
		var json_parser = JSON.new()
		var error = json_parser.parse(data)
		
		if error == OK:
			var tile_data = json_parser.data
			# Create a new gridTile instance
			var tile = gridTileScene.instantiate()
			tile.tileName = tile_data.get("tileName", "Unnamed Tile")
			tile.image = load(tile_data.get("image", "res://Art/default.png")) # Provide a fallback texture path
			tile.description = tile_data.get("description", "No description available")
			tile.craftQuantity = int(tile_data.get("craftQuantity", 1))
			
			# Add to tiles dictionary with tileName as the key
			tiles[tile.tileName] = tile
		else:
			print("Error parsing JSON in file", file_path)
	else:
		print("Failed to open file:", file_path)

# Function to get a tile by name
func get_tile(tile_name: String) -> gridTile:
	return tiles.get(tile_name, null)