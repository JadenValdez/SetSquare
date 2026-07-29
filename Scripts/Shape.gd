extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var polygon_2d: Polygon2D = $Polygon2D

var shape_color: Color
var line_color: Color
var fill: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.modulate = line_color
	polygon_2d.modulate = shape_color
	
	match fill:
		"Solid":
			polygon_2d.modulate.a = 1
		"Shaded":
			polygon_2d.modulate.a = 0.5
		"Empty":
			polygon_2d.modulate.a = 0
