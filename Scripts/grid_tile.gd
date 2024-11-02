extends Control

class_name gridTile

var tileName: String = "baseTile"
var image : Texture2D = preload("res://Art/sampleTile.png")
var description: String = "No description"
var craftQuantity: int = 1
var components: Array

func _ready() -> void:
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
