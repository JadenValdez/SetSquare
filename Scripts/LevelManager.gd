extends Node

var RemainingLevelAnswers: Array

func _ready() -> void:
	SignalBus.start_game.connect(StartGame)

func StartGame():
	GameManager.CurrentLevel = 1
	PlayerInformation.Score = 0
	StartNewLevel()
	StartNewRound()
	
	
func StartNewLevel() -> void:
	RemainingLevelAnswers = GameManager.LEVELS[GameManager.CurrentLevel].Answers.duplicate(true)
	GameManager.BoardRows = GameManager.LEVELS[GameManager.CurrentLevel].Rows
	GameManager.BoardColumns = GameManager.LEVELS[GameManager.CurrentLevel].Columns
	GameManager.CurrentRound = 0
	
	
func StartNewRound() -> void:
	SignalBus.remove_answer_tabs.emit()
	SignalBus.delete_all_tiles.emit()
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
	PlayerInformation.SelectedTiles = {}
	PlayerInformation.FoundSets = {}
	AnswerCreator.CurrentAnswerAmount = 0
	TileGenerator.GenerateTiles()
	
