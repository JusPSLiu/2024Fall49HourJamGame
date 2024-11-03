extends TextureRect

@export var displayNumber = 1

@onready var children = get_children()

func _ready() -> void:
	update_display()

func update_display():
	var currnum = displayNumber
	for child in children:
		if (currnum > 0):
			currnum-=1
			child.show()
		else:
			child.hide()

func set_to_body_part(newnum : int) -> void:
	displayNumber = newnum
	update_display()
