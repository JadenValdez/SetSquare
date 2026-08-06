extends Node2D

var selected_tiles: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.move_remaining_answer_tabs.connect(_move_remaining_answer_tabs)
	SignalBus.remove_answer_tabs.connect(_remove_answer_tabs)
	
	for row in range(GameManager.BoardRows):
		for column in range(GameManager.BoardColumns):
			var line_2d = Line2D.new()
			line_2d.points = PackedVector2Array(
				[Vector2(-6, -6), Vector2(6, -6), Vector2(6, 6), Vector2(-6, 6)]
				)
			line_2d.closed = true
			line_2d.width = 2
			line_2d.scale = Vector2(8.0/GameManager.BoardColumns, 8.0/GameManager.BoardColumns)
			if GameManager.BoardColumns == GameManager.BoardRows:
				line_2d.position = Vector2(-64 + ((128.0/(GameManager.BoardColumns * 2)) * (column * 2 + 1)), -64 + ((128.0/(GameManager.BoardColumns * 2)) * (row * 2 + 1)))
			else:
				line_2d.position = Vector2(-64 + ((128.0/(GameManager.BoardColumns * 2)) * (column * 2 + 1)), -64 + ((128.0/(GameManager.BoardColumns * 2)) * (row * 2 + 2)))
			
			line_2d.modulate = Color(1, 1, 1, 1)
			for tile_id in selected_tiles:
				if selected_tiles[tile_id].Row == row + 1 && selected_tiles[tile_id].Column == column + 1:
					line_2d.modulate = Color(1, 1, 0, 1)
			add_child(line_2d)

func _move_remaining_answer_tabs() -> void:
	self.position += Vector2(-80, 0)
	
func _remove_answer_tabs() -> void:
	queue_free()
