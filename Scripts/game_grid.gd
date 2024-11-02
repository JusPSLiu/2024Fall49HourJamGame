extends Control
class_name gameGrid

@export var gameGridContainer: GridContainer
@export var tileOrder: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tileName in tileOrder:
		var newTile = GridTileSingleton.get_tile(tileName)
		gameGridContainer.add_child(newTile)
