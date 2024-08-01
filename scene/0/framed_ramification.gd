class_name FramedRamification extends PanelContainer


@export var ramification: Ramification:
	set(ramification_):
		ramification = ramification_
		init_powers()
		indexRamification.text = str(ramification.index)
		indexPlatform.text = str(ramification.platform_index)
	get:
		return ramification
@export var first: PowerProbability
@export var second: PowerProbability
@export var indexRamification: Label
@export var indexPlatform: Label


func init_powers() -> void:
	#for _i in Global.arr.order.size():
	#	var order = Global.arr.order[_i]
	for order in Global.arr.order:
		var powerProbability = get(order)
		powerProbability.club = ramification.graph.judge.get(order)
 		#powerProbability.platform = ramification.platforms[_i]
