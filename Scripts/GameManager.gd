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
		"Columns": 2,
		"List": "Normal",
		"Answers": [0, 0, 0, 1, 1]
	},
	
	2: {
		"Rows": 2,
		"Columns": 3,
		"List": "Normal",
		"Answers": [0, 1, 1, 2, 2]
	},
	
	3: {
		"Rows": 3,
		"Columns": 3,
		"List": "Normal",
		"Answers": [1, 1, 2, 2, 3]
	},
	
	4: {
		"Rows": 2,
		"Columns": 3,
		"List": "Large",
		"Answers": [1, 1, 2, 2, 2]
	},
	
	5: {
		"Rows": 3,
		"Columns": 3,
		"List": "Large",
		"Answers": [1, 2, 2, 3, 3]
	},
		
	6: {
		"Rows": 3,
		"Columns": 4,
		"List": "Large",
		"Answers": [2, 3, 4, 5, 6]
	},
	
	7: {
		"Rows": 2,
		"Columns": 3,
		"List": "Extra",
		"Answers": [1, 2, 2, 2, 3]
	},
	
	8: {
		"Rows": 3,
		"Columns": 3,
		"List": "Extra",
		"Answers": [2, 2, 3, 3, 4]
	},
	
	9: {
		"Rows": 3,
		"Columns": 4,
		"List": "Extra",
		"Answers": [2, 4, 6, 8, 10]
	},
}

var TileList: Array
var LargeTileList: Array
var ExtraTileList: Array
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
					LargeTileList.append(str(i) + str(j) + str(k) + str(l)) 
					
					for m in range(3):
						ExtraTileList.append(str(i) + str(j) + str(k) + str(l) + str(m)) 
