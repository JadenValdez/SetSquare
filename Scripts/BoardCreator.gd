extends Node2D

const COLORS: Dictionary = {
	"Red": Color(1, 0, 0, 1),
	"Yellow": Color(1, 1, 0, 1),
	"Blue": Color(0, 0, 1, 1)
}

const SHAPES: Dictionary = {
	"Circle": null,
	"Square": null,
	"Triangle": null
}

var tile_list: Array
var rng = RandomNumberGenerator.new()
var index: int

func _ready() -> void:
	create_tile_list()

func create_tile_list() -> void:
	for i in COLORS:
		for j in SHAPES:
			for k in range(3):
				tile_list.append({
					"Color": i,
					"Shape": j,
					"Amount": k+1
				})

func create_board() -> void:
	for i in range(3):
		for j in range(3):
			index = rng.randi(tile_list.size())
