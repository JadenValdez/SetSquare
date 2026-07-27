extends Node

var CurrentLevel: int
var CurrentRound: int

var BoardRows: int
var BoardColumns: int
var List: String
var AnswerAmount: int

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
