class_name DispositionResource extends Resource


@export var manas: Array:
	set(manas_):
		manas = manas_
		roll_indexs()
	get:
		return manas
@export var indexs: Array

const segments = [
	[],
	[0,1,2],
	[3,4,5],
	[6,7,8,9,10,11],
	[12,13,14]
]


func roll_indexs() -> void:
	manas.sort_custom(func(a, b): return a < b)
	
	for segment in segments.size():
		var options = segments[segment].duplicate()
		options.shuffle()
		indexs.append_array(options)
