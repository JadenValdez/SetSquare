extends Node2D

const DIAMOND = preload("res://Scenes/Shapes/Diamond.tscn")
const SQUARE = preload("res://Scenes/Shapes/Square.tscn")
const TRIANGLE = preload("res://Scenes/Shapes/Triangle.tscn")
@onready var color_rect: ColorRect = $ColorRect
@onready var line_2d: Line2D = $Line2D

var tile_id: String
var tile_shade: Color = Color(0, 0, 0, 1)

var tile_row: int
var tile_column: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.clear_selected_tiles.connect(_clear_selected_tiles)
	SignalBus.delete_all_tiles.connect(_delete_all_tiles)
	
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


func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		
		#if tile is already selected, unselect it
		for x in PlayerInformation.SelectedTiles:
			if x == tile_id:
				line_2d.hide()
				PlayerInformation.SelectedTiles.erase(tile_id)
				return
				
		line_2d.show()
		PlayerInformation.SelectedTiles[tile_id] = {
			"Row": tile_row,
			"Column": tile_column
		}
		if PlayerInformation.SelectedTiles.size() >= 3:
			AnswerCheck.CheckAnswer()
			
func _clear_selected_tiles() -> void:
	line_2d.hide()
	

func delete_all_tiles() -> void:
	queue_free()
