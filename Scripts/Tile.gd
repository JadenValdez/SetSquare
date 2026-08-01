extends Node2D

const DIAMOND = preload("res://Scenes/Shapes/Diamond.tscn")
const SQUARE = preload("res://Scenes/Shapes/Square.tscn")
const TRIANGLE = preload("res://Scenes/Shapes/Triangle.tscn")
@onready var color_rect: ColorRect = $ColorRect
@onready var line_2d: Line2D = $Line2D

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


func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		
		#if tile is already selected, unselect it
		for x in PlayerInformation.SelectedTiles:
			if x == tile_id:
				line_2d.hide()
				PlayerInformation.SelectedTiles.erase(tile_id)
				PlayerInformation.SelectedTilesAmount -= 1
				return
				
		#if the player already selected 3 tiles, do nothing
		if PlayerInformation.SelectedTilesAmount >= 3:
			pass
			
		#otherwise, add this tile to the selected tiles list
		else:
			line_2d.show()
			PlayerInformation.SelectedTiles.append(tile_id)
			PlayerInformation.SelectedTilesAmount += 1
