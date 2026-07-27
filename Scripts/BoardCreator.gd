extends Node2D





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
	create_board()

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
func create_board() -> void:
	chosen_tiles = []
	answers = {}
	total_spaces = GameManager.BoardRows * GameManager.BoardColumns
	current_space = 0
	for i in range(GameManager.BoardRows):
		for j in range(GameManager.BoardColumns):
			#start looking for answers once enough spaces have been filled out
			if total_spaces - current_space <= GameManager.AnswerAmount && GameManager.AnswerAmount != 0:
				for x in answers.keys():
					if answers[x] > GameManager.AnswerAmount:
						pass
					else:
						GameManager.AnswerAmount -= answers[x]
						answers.erase(x)
						get_answers(x)
						break
						
			else: 
				size = tile_list.size()
				get_answers(tile_list[randi() % size])
				
			current_space += 1
			
	print(chosen_tiles)
	SignalBus.create_board.emit(chosen_tiles.duplicate(true))

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
