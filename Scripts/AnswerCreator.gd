extends Node2D

const ANSWER_TAB = preload("res://Scenes/AnswerTab.tscn")

var CurrentAnswerAmount: int

func _ready() -> void:
	pass # Replace with function body.
	
func CreateAnswerTab() -> void:
	SignalBus.move_remaining_answer_tabs.emit()
	var instance = ANSWER_TAB.instantiate()
	instance.selected_tiles = PlayerInformation.SelectedTiles
	instance.position = Vector2(576 + 80 * CurrentAnswerAmount, 608)
	add_child(instance)
	CurrentAnswerAmount += 1
