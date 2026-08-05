extends Node2D

const TILE = preload("res://Scenes/Tile.tscn")
@onready var label: Label = $"../Label"

var current_row: int
var current_column: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.create_board.connect(_create_board)
	SignalBus.update_score.connect(_update_score)

func _create_board(chosen_tiles: Array) -> void:
	chosen_tiles.shuffle()
	current_row = 1
	current_column = 1
	for tile in chosen_tiles:
		if current_column > GameManager.BoardColumns:
			current_column = 1
			current_row += 1
		var instance = TILE.instantiate()
		
		instance.tile_id = tile
		if tile.length() >= 4:
			instance.tile_shade = TileInformation.SHADE[tile[3]]
		else:
			instance.tile_shade = Color(0, 0, 0, 1)
			
		#change position and size based on how many rows/columns there are
		instance.scale = Vector2(4.0/GameManager.BoardColumns, 4.0/GameManager.BoardColumns)
		if GameManager.BoardColumns == GameManager.BoardRows:
			instance.position = Vector2(-256 + ((512.0/(GameManager.BoardColumns * 2)) * (current_column * 2 - 1)), -256 + ((512.0/(GameManager.BoardColumns * 2)) * (current_row * 2 - 1)))
		else:
			instance.position = Vector2(-256 + ((512.0/(GameManager.BoardColumns * 2)) * (current_column * 2 - 1)), -256 + ((512.0/(GameManager.BoardColumns * 2)) * (current_row * 2)))
		instance.tile_row = current_row
		instance.tile_column = current_column
		add_child(instance)
		current_column += 1


func _on_button_pressed() -> void:
	SignalBus.start_game.emit()


func _on_button_2_pressed() -> void:
	AnswerCheck.CheckSets()

func _update_score() -> void:
	label.text = "Score: " + str(PlayerInformation.Score)
	label.modulate = Color(1, 1, 0, 1)
	await get_tree().create_timer(0.1).timeout
	label.modulate = Color(1, 1, 1, 1)
