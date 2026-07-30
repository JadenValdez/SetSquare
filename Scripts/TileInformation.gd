extends Node

const SHAPES: Dictionary = {
	0: "Circle",
	1: "Square",
	2: "Triangle"
}

const COLORS: Dictionary = {
	0: Color(1, 0, 0, 1), #red
	1: Color(1, 1, 0, 1), #yellow
	2: Color(0, 0, 1, 1) #blue
}

const FILL: Dictionary = {
	0: "Solid",
	1: "Shaded",
	2: "Empty"
}

const SHADE: Dictionary = {
	0: Color(0, 0, 0, 1), #black
	1: Color(0.5, 0.5, 0.5, 1), #grey
	2: Color(1, 1, 1, 1) #white
}

#possibly orange, green, and purple line color if 5th
