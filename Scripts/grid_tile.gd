extends Control

class_name gridTile

var tileName: String = "baseTile"
var image : Texture2D = preload("res://Art/sampleTile.png")
var description: String = "No description"
var craftQuantity: int = 1
var components: Array
var componentTiles : Array

@onready var neededTilesHolder: HBoxContainer = $InfoCard/ColorRect/VBoxContainer/HBoxContainer
@onready var craftsound : AudioStreamPlayer = $craftsound
var ingredientTileScene: PackedScene = preload("res://Scenes/IngredientTile.tscn")

func _ready() -> void:
	$InfoCard.hide()
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
	$InfoCard/ColorRect/VBoxContainer/Label.text = tileName
	$InfoCard/ColorRect/VBoxContainer/Label2.text = description
	for component in components:
		var iTile = ingredientTileScene.instantiate()
		var iImage = GridTileSingleton.get_tile(component["tileName"]).image
		iTile.setVariables(component["tileName"], iImage, component["quantity"], component["catalyst"])
		neededTilesHolder.add_child(iTile)
		componentTiles.append(iTile)
	refresh()

func refresh():
	var quantity = GridTileSingleton.getQuantity(tileName)
	$Label.text = str(quantity)
	var canAfford = true
	for cTile in componentTiles:
		if cTile.catalyst and GridTileSingleton.tileQuantities[cTile.ingredientName] > 0:
			continue
		elif cTile.quantity > GridTileSingleton.tileQuantities[cTile.ingredientName]:
			canAfford = false
			break
	$TextureButton.disabled = true if !canAfford else false

func _on_Button_mouse_entered():
	$InfoCard.show()

func _on_Button_mouse_exited():
	$InfoCard.hide()

func _on_texture_button_pressed() -> void:
	GridTileSingleton.tileQuantities[tileName] += 1
	for cTile in componentTiles:
		if cTile.catalyst:
			continue
		GridTileSingleton.tileQuantities[cTile.ingredientName] -= cTile.quantity
	GridTileSingleton.refreshAllTileQuantities()
	craftsound.play()
