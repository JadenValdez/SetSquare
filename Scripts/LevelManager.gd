extends Node

var RemainingLevelAnswers: Array

func _ready() -> void:
	SignalBus.start_game.connect(StartGame)

func StartGame():
	print(1)
	GameManager.CurrentLevel = 1
	StartNewLevel()
	StartNewRound()
	
	
func StartNewLevel() -> void:
	print(2)
	RemainingLevelAnswers = GameManager.LEVELS[GameManager.CurrentLevel].Answers.duplicate(true)
	GameManager.BoardRows = GameManager.LEVELS[GameManager.CurrentLevel].Rows
	GameManager.BoardColumns = GameManager.LEVELS[GameManager.CurrentLevel].Columns
	GameManager.CurrentRound = 0
	
	
func StartNewRound() -> void:
	print(3)
	if RemainingLevelAnswers.is_empty():
		GameManager.CurrentLevel += 1
		if GameManager.CurrentLevel >= 6:
			pass
			#player wins
			return
		else:
			StartNewLevel()
			
	
		
	GameManager.CurrentRound += 1
	GameManager.AnswerAmount = RemainingLevelAnswers[randi() % RemainingLevelAnswers.size()]
	RemainingLevelAnswers.erase(GameManager.AnswerAmount)
	TileGenerator.GenerateTiles()
	
