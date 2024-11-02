extends Control

class_name gridTile

var tileName: String = "baseTile"
var image : Texture2D = preload("res://Art/sampleTile.png")
var description: String = "No description"
var craftQuantity: int = 1
var components: Array

@onready var neededTilesHolder: HBoxContainer = $InfoCard/ColorRect/VBoxContainer/HBoxContainer
var ingredientTileScene: PackedScene = preload("res://Scenes/IngredientTile.tscn")

func _ready() -> void:
	$InfoCard.hide()
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
	for component in components:
		var iTile = ingredientTileScene.instantiate()
		var iImage = GridTileSingleton.get_tile(component["tileName"]).image
		iTile.setVariables(iImage, component["quantity"])
		neededTilesHolder.add_child(iTile)

func refreshQuantity():
	var quantity = GridTileSingleton.getQuantity(tileName) 
	$Label.text = str(quantity) if quantity > 1 else ""

func _on_Button_mouse_entered():
	$InfoCard.show()

func _on_Button_mouse_exited():
	$InfoCard.hide()
