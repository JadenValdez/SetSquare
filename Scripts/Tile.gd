extends Node2D

const DIAMOND = preload("res://Scenes/Shapes/Diamond.tscn")
const SQUARE = preload("res://Scenes/Shapes/Square.tscn")
const TRIANGLE = preload("res://Scenes/Shapes/Triangle.tscn")
@onready var color_rect: ColorRect = $ColorRect

var tile_id: String
var tile_shade: Color = Color(0, 0, 0, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.modulate = tile_shade
	
	#shape
	var instance
	match tile_id[0]:
		"0":
			instance = DIAMOND.instantiate()
		"1":
			instance = SQUARE.instantiate()
		"2":
			instance = TRIANGLE.instantiate()
	
	#color
	instance.shape_color = TileInformation.COLORS[tile_id[1]]
	instance.line_color = TileInformation.COLORS[tile_id[1]]
	
	#fill
	instance.fill = TileInformation.FILL[tile_id[2]]
	
	add_child(instance)
