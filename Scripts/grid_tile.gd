extends Control

class_name gridTile

@export var tileName: String = "baseTile"
@export var image : Texture2D = preload("res://Art/sampleTile.png")
@export var description: String = "No description"
@export var craftQuantity: int = 1

func _ready() -> void:
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
