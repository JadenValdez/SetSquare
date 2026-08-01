extends Node

var CurrentLevel: int = 0
var CurrentRound: int = 0

var BoardRows: int
var BoardColumns: int
var List: String

var AnswerAmount: int
var Sets: Dictionary

const LEVELS: Dictionary = {
	#column amounts will always be equal, or 1 more than the amount of rows
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

var TileList: Array
var LargeTileList: Array
#maybe an "extra" list with 5?

func _ready() -> void:
	CreateTileLists()
	
#creates a list of ids that correspond to each tile of the entire tile list
func CreateTileLists() -> void:
	TileList = []
	LargeTileList = []
	for i in range(3):
		for j in range(3):
			for k in range(3):
				
				TileList.append(str(i) + str(j) + str(k)) 
					
				for l in range(3):
					LargeTileList.append(str(i) + str(j) + str(l) + str(k)) 
