@tool
class_name SpiralResource extends Resource


@export_enum("memory", "blood", "breath") var type: String
@export_enum("50", "70", "80", "100", "140", "160") var title: String:
	set(title_):
		title = title_
		length = int(title)
		
		if length % 50 == 0:
			type = "memory"
		if length % 70 == 0:
			type = "blood"
		if length % 80 == 0:
			type = "breath"
	get:
		return title
@export var length: int

var bridges: Array[int]
