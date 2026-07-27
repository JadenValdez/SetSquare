extends Node2D

const COLORS: Dictionary = {
	0: "Red",
	1: "Yellow",
	2: "Blue"
}

const SHAPES: Dictionary = {
	0: "Circle",
	1: "Square",
	2: "Triangle"
}

const FILL: Dictionary = {
	0: "Solid",
	1: "Shaded",
	2: "Empty"
}

var tile_id: String

var tile_color_name: String
var tile_shape_name: String
var tile_icon_amount: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tile_id.length() == 3:
		pass
	elif tile_id.length() == 4:
		pass
