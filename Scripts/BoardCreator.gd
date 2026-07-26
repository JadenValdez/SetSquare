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

const LEVELS: Dictionary = {
	1: {
		"Rows": 2,
		"Columns": 3,
		"List": "Normal",
		"Answers": [0, 1, 1, 2, 2]
	},
	
	2: {
		"Rows": 3,
		"Columns": 3,
		"List": "Normal",
		"Answers": [1, 1, 2, 2, 3]
	},
	
	3: {
		"Rows": 3,
		"Columns": 4,
		"List": "Normal",
		"Answers": [2, 2, 3, 4, 5]
	},
	
	4: {
		"Rows": 3,
		"Columns": 4,
		"List": "Large",
		"Answers": [3, 3, 4, 5, 6]
	},
	
	5: {
		"Rows": 4,
		"Columns": 4,
		"List": "Large",
		"Answers": [4, 5, 6, 8, 10]
	},
		
}

var tile_list: Array
var large_tile_list: Array
#maybe an "extra" list with 5?

var size: int

var chosen_tiles: Array
var answer_tile: String
var answers: Dictionary

var total_spaces: int
var current_space: int

func _ready() -> void:
	create_tile_lists()
	create_board(3, 3, 2)

#creates a list of ids that correspond to each tile of the entire tile list
func create_tile_lists() -> void:
	tile_list = []
	large_tile_list = []
	for i in range(3):
		for j in range(3):
			for k in range(3):
				
				tile_list.append(str(i) + str(j) + str(k)) 
					
				for l in range(3):
					large_tile_list.append(str(i) + str(j) + str(l) + str(k)) 

#creates a board of the given size
func create_board(rows: int, columns: int, current_answer_amount: int) -> void:
	chosen_tiles = []
	answers = {}
	total_spaces = rows * columns
	current_space = 0
	for i in range(rows):
		for j in range(columns):
			#start looking for answers once enough spaces have been filled out
			if total_spaces - current_space <= current_answer_amount && current_answer_amount != 0:
				for x in answers.keys():
					if answers[x] > current_answer_amount:
						pass
					else:
						current_answer_amount -= answers[x]
						answers.erase(x)
						get_answers(x)
						break
						
			else: 
				size = tile_list.size()
				get_answers(tile_list[randi() % size])
				
			current_space += 1
			
	print(chosen_tiles)
	SignalBus.create_board(chosen_tiles)

#get the answer tiles based on the list of currrently chosen tiles
func get_answers(new_tile: String) -> void:
	for x in chosen_tiles:
		
		answer_tile = ""
		
		#use range 4 for larger list
		for i in range(3):
			if x[i] == new_tile[i]:
				answer_tile += x[i]
			else: 
				match [x[i], new_tile[i]]:
					["0", "1"]:
						answer_tile += "2"
					["1", "0"]:
						answer_tile += "2"
					["0", "2"]:
						answer_tile += "1"
					["2", "0"]:
						answer_tile += "1"
					_:
						answer_tile += "0"
					
		tile_list.erase(answer_tile)
	
		if !answers.has(answer_tile):
			answers[answer_tile] = 1
		else:
			answers[answer_tile] += 1
	
	chosen_tiles.append(new_tile)
	tile_list.erase(new_tile)
