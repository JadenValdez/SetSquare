extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.create_board.connect(_create_board)
	
	
	await get_tree().create_timer(1).timeout
	SignalBus.start_game.emit()

func _create_board(chosen_tiles: Array) -> void:
	chosen_tiles.shuffle()
	for tile in chosen_tiles:
		pass
