class_name DispositionResource extends Resource


@export var powers: Array:
	set(powers_):
		powers = powers_
		roll_indexs()
	get:
		return powers
@export var indexs: Array

const segments = [
	[],
	[0,1,2],
	[3,4,5],
	[6,7,8,9,10,11],
	[12,13,14]
]


func roll_indexs() -> void:
	#var _i = 0
	powers.sort_custom(func(a, b): return a < b)
	
	for segment in segments.size():
		var options = segments[segment].duplicate()
		options.shuffle()
		indexs.append_array(options)
