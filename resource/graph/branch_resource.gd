class_name BranchResource extends Resource


@export var graph: GraphResource
@export var ramifications: Array:
	set(ramifications_):
		ramifications = ramifications_
		
		if !ramifications[0].is_root:
			calc_prize()
	get:
		return ramifications

var prize: float = 0
var is_swallowed: bool = false

func calc_prize() -> void:
	prize = 0
	var ramification = ramifications[1]
	
	for order in Global.arr.order:
		var proportion = ramification.get(order + "_proportion")
		
		match order:
			"second":
				proportion *= -1
		
		prize += proportion
