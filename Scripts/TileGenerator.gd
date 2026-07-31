extends Node2D


var TileList: Array

var ChosenTiles: Array
var AnswerTile: String
var Answers: Dictionary
var Sets: Array

var TotalSpaces: int
var CurrentSpace: int

func _ready() -> void:
	pass


#creates a board of the given size
func GenerateTiles() -> void:
	print(4)
	ChosenTiles = []
	Answers = {}
	Sets = []
	#change tile list based on current list type
	TileList = GameManager.TileList.duplicate(true)
	TotalSpaces = GameManager.BoardRows * GameManager.BoardColumns
	CurrentSpace = 0
	for i in range(GameManager.BoardRows):
		for j in range(GameManager.BoardColumns):
			#start looking for answers once enough spaces have been filled out
			if TotalSpaces - CurrentSpace <= GameManager.AnswerAmount && GameManager.AnswerAmount != 0:
				for x in Answers.keys():
					if Answers[x].Amount > GameManager.AnswerAmount:
						pass
					else:
						GameManager.AnswerAmount -= Answers[x].Amount
						for pair in Answers[x].HalfSet:
							for id in Answers[x].HalfSet[pair]:
								Sets.append(id)
							Sets.append(x)
							
						Answers.erase(x)
						get_answers(x)
						break
						
			else: 
				get_answers(TileList[randi() % TileList.size()])
				
			CurrentSpace += 1
			
	print(ChosenTiles)
	GameManager.Sets = Sets.duplicate(true)
	SignalBus.create_board.emit(ChosenTiles.duplicate(true))

#get the answer tiles based on the list of currrently chosen tiles
func get_answers(new_tile: String) -> void:
	for x in ChosenTiles:
		
		AnswerTile = ""
		
		#use range 4 for larger list
		for i in range(3):
			if x[i] == new_tile[i]:
				AnswerTile += x[i]
			else: 
				match [x[i], new_tile[i]]:
					["0", "1"]:
						AnswerTile += "2"
					["1", "0"]:
						AnswerTile += "2"
					["0", "2"]:
						AnswerTile += "1"
					["2", "0"]:
						AnswerTile += "1"
					_:
						AnswerTile += "0"
					
		TileList.erase(AnswerTile)
	
		if !Answers.has(AnswerTile):
			Answers[AnswerTile] = {
				"Amount" = 1,
				"HalfSet" = [[x, new_tile]]
			}
		else:
			Answers[AnswerTile].Amount += 1
			Answers[AnswerTile].HalfSet.append([x, new_tile])
	
	ChosenTiles.append(new_tile)
	TileList.erase(new_tile)
