extends Node2D

const TILE = preload("res://Scenes/Tile.tscn")

var current_row: int
var current_column: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.create_board.connect(_create_board)
	
	
	await get_tree().create_timer(1).timeout
	SignalBus.start_game.emit()

func _create_board(chosen_tiles: Array) -> void:
	chosen_tiles.shuffle()
	current_row = 0
	current_column = 0
	for tile in chosen_tiles:
		if current_column >= GameManager.BoardColumns:
			current_column = 0
			current_row += 1
		var instance = TILE.instantiate()
		
		instance.tile_id = tile
		if tile.length() >= 4:
			instance.tile_shade = TileInformation.SHADE[tile[3]]
		else:
			instance.tile_shade = Color(0, 0, 0, 1)
			
		#change position and size based on how many rows/columns there are
		
		add_child(instance)
