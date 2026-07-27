extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.create_board.connect(_create_board)

func _create_board(chosen_tiles: Array) -> void:
	chosen_tiles.shuffle()
	for tile in chosen_tiles:
		pass
