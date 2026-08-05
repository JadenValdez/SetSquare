extends Node

var tiles_found: int

func _ready() -> void:
	pass # Replace with function body.

func CheckAnswer() -> void: 
	for set_id in PlayerInformation.FoundSets:
		
		tiles_found = 0
		
		for tile_id in PlayerInformation.SelectedTiles:
			
			for tile_id_2 in PlayerInformation.FoundSets[set_id]:
				if tile_id == tile_id_2:
					tiles_found += 1
					if tiles_found >= 3:
						print("set already found")
						PlayerInformation.SelectedTiles = {}
						return
						#duplicate set
						#no score change
	
	for set_id in GameManager.Sets:
		
		tiles_found = 0
		
		for tile_id in PlayerInformation.SelectedTiles:

			for tile_id_2 in GameManager.Sets[set_id]:
				
				if tile_id == tile_id_2:
					tiles_found += 1
					
					if tiles_found >= 3:
						print("selected tiles form a set")
						PlayerInformation.FoundSets[PlayerInformation.FoundSets.size()] = PlayerInformation.SelectedTiles.duplicate(true)
						PlayerInformation.Score += 1
						SignalBus.update_score.emit()
						AnswerCreator.CreateAnswerTab()
						PlayerInformation.SelectedTiles = {}
						return
	
	print("selected tiles do not form a set")
	PlayerInformation.Score -= 1
	SignalBus.update_score.emit()
	PlayerInformation.SelectedTiles = {}
	#set was not found

func CheckSets() -> void:
	if PlayerInformation.FoundSets.size() >= GameManager.Sets.size():
		PlayerInformation.Score += 2
		SignalBus.update_score.emit()
	else:
		for set_id in GameManager.Sets:
			
			for set_id_2 in PlayerInformation.FoundSets:
				
				tiles_found = 0
				
				for tile_id in GameManager.Sets[set_id]:
					
					for tile_id_2 in PlayerInformation.FoundSets[set_id_2]:
						
						if tile_id == tile_id_2:
							tiles_found += 1
							
				if tiles_found >= 3:
					break
					
			if !(tiles_found >= 3):
				pass
				#this set was not found
				#show visual that shows it where it was on the board
	
	LevelManager.StartNewRound()
