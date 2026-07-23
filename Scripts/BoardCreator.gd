extends Node2D

const COLORS: Dictionary = {
	0: "Red",
	1: "Yellow",
	2: "Blue"
}

const SHAPES: Dictionary = {
	0: "Circle",
	1: "Square",
	2: "Triangle"
}

const FILL: Dictionary = {
	0: "Solid",
	1: "Shaded",
	2: "Empty"
}

var tile_list: Dictionary
var large_tile_list: Dictionary
#maybe an "extra" list with 5?

var size: int
var chosen_tiles: Array
var answer_tile: String
var answers: Dictionary
var index: String

func _ready() -> void:
	create_tile_lists()
	create_board(2, 3)

func create_tile_lists() -> void:
	tile_list = {}
	large_tile_list = {}
	for i in range(3):
		for j in range(3):
			for k in range(3):
				
				tile_list[str(i) + str(j) + str(k)] = {
					"Color": COLORS[i],
					"Shape": SHAPES[j],
					"Amount": k+1
					}
					
				for l in FILL:
					large_tile_list[str(i) + str(j) + str(l) + str(k)] = {
						"Color": COLORS[i],
						"Shape": SHAPES[j],
						"Fill": FILL[l],
						"Amount": k+1
					}

func create_board(rows: int, columns: int) -> void:
	chosen_tiles = []
	answers = {}
	for i in range(rows):
		for j in range(columns):
			size = tile_list.size()
			index = tile_list.keys()[randi() % size]
			get_answers(tile_list[index])

func get_answers(new_tile: String) -> void:
	for x in chosen_tiles:
		answer_tile = ""
		if x[0] == new_tile[0]:
			answer_tile += x[0]
	chosen_tiles.append(new_tile)
