extends Control

class_name ingredientTile

func setVariables(image: Texture2D, quantity: int):
	$TextureRect.texture = image
	$TextureRect.scale = Vector2(64/$TextureRect.size.x,64/$TextureRect.size.y)
	$Label.text = str(quantity) if quantity > 1 else ""
