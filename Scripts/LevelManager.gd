extends Node

var RemainingLevelAnswers: Array

func _ready() -> void:
	SignalBus.start_game.connect(StartGame)

func StartGame():
	GameManager.CurrentLevel = 1
	StartNewLevel()
	
func StartNewLevel() -> void:
	RemainingLevelAnswers = GameManager.LEVELS[GameManager.CurrentLevel].Answers.duplicate(true)
	GameManager.CurrentRound = 0
	
func StartNewRound() -> void:
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
	
