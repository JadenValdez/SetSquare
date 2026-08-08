extends Node2D


var TileList: Array

var ChosenTiles: Array
var AnswerTile: String
var Answers: Dictionary
var Sets: Dictionary
var TempSet: Dictionary
var CurrentAnswer:int

var TotalSpaces: int
var CurrentSpace: int

func _ready() -> void:
	pass


#creates a board of the given size
func GenerateTiles() -> void:
	ChosenTiles = []
	Answers = {}
	Sets = {}
	CurrentAnswer = 0
	#change tile list based on current list type
	match GameManager.List:
		"Normal":
			TileList = GameManager.TileList.duplicate(true)
		"Large": 
			TileList = GameManager.LargeTileList.duplicate(true)
		"Extra":
			TileList = GameManager.ExtraTileList.duplicate(true)
			
	TotalSpaces = GameManager.BoardRows * GameManager.BoardColumns
	CurrentSpace = 0
	for i in range(GameManager.BoardRows):
		for j in range(GameManager.BoardColumns):
			#start looking for answers once enough spaces have been filled out
			print(GameManager.AnswerAmount)
			if TotalSpaces - CurrentSpace <= GameManager.AnswerAmount && GameManager.AnswerAmount != 0:
				for x in Answers.keys():
					if Answers[x].Amount > GameManager.AnswerAmount:
						pass
					else:
						
						GameManager.AnswerAmount -= Answers[x].Amount
						for pair_id in Answers[x].HalfSet:
							TempSet = {}
							for id in Answers[x].HalfSet[pair_id]:
								TempSet[id] = {
									"Row": 0,
									"Column": 0
								}
							TempSet[x] = {
								"Row": 0,
								"Column": 0
							}
							CurrentAnswer += 1
							
							Sets[CurrentAnswer] = TempSet
							
						Answers.erase(x)
						get_answers(x)
						break
						
			else: 
				if TileList.size() == 0:
					pass
					#have to come up with some way of still having stuff
					#3x4 is too big for 3 set
				else:
					get_answers(TileList[randi() % TileList.size()])
				
			CurrentSpace += 1
			
	print(ChosenTiles)
	GameManager.Sets = Sets.duplicate(true)
	print(GameManager.Sets)
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
				"HalfSet" = {
					1: [x, new_tile]
				}
			}
		else:
			Answers[AnswerTile].Amount += 1
			Answers[AnswerTile].HalfSet[Answers[AnswerTile].Amount] =[x, new_tile]
	
	ChosenTiles.append(new_tile)
	TileList.erase(new_tile)
