extends Control

class_name ingredientTile

var quantity: int
var ingredientName: String
var catalyst: bool

func setVariables(iName: String, image: Texture2D, q: int, c: bool):
	ingredientName = iName
	quantity = q
	catalyst = c
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
	$Label.text = str(quantity) if !c else ""
