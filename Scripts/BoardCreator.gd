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

const FILL: Dictionary = {
	"Solid": null,
	"Shaded": null,
	"Empty": null
}

var tile_list: Array
var large_tile_list: Array
#maybe an "extra" list with 5?

var chosen_tiles: Array
var rng = RandomNumberGenerator.new()
var index: int

func _ready() -> void:
	create_tile_lists()
	create_board()

func create_tile_lists() -> void:
	tile_list = []
	large_tile_list = []
	for i in COLORS:
		for j in SHAPES:
			for k in range(3):
				tile_list.append({
					"Color": i,
					"Shape": j,
					"Amount": k+1
					})
				for l in FILL:
					large_tile_list.append({
						"Color": i,
						"Shape": j,
						"Fill": l,
						"Amount": k+1
					})

func create_board() -> void:
	chosen_tiles = []
	for i in range(3):
		for j in range(3):
			index = rng.randi_range(0, tile_list.size() - 1)
			chosen_tiles.append(tile_list[index])
			tile_list.remove_at(index)
			check_answers()

func check_answers() -> void:
	pass
