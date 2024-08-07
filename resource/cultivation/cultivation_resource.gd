class_name CultivationResource extends Resource


@export var spirals: Array[SpiralResource]
@export var alpha_indexs: Array[int]
@export var beta_indexs: Array[int]
@export var gamma_indexs: Array[int]
@export var branch_count: int

const types = ["alpha", "beta", "gamma"]


func get_best_type(dancefloor_: Dancefloor, crystals_: Array) -> String:
	var options = {}
	
	for type in types:
		var option = {}
		option.manas = []
		option.charges = []
		option.chances = []
		option.weight = 0
		var indexs = get(type + "_indexs")
		
		for _i in indexs.size():
			var crystal = crystals_[_i]
			#var spiral = spirals[_i]
			var bridge = dancefloor_.bridges.get_child(indexs[_i])
			var manas = []
			var chances = []
			var charge = floor(crystal.volume / bridge.length)
			
			for platform in bridge.platforms:
				manas.append(platform.mana)
			
			if _i > 0:
				manas[0] += 1
			
			for mana in manas:
				var chance = 1.0
				
				if charge < mana:
					chance = float(charge) / (mana + charge)
				
				chances.append(chance)
				option.weight += chance * mana * 0.5
			
			option.manas.append(manas)
			option.charges.append(charge)
			option.chances.append(chances)
		
		options[type] = option
		if dancefloor_.club.order == "first":
			print([type, option.manas, option.charges, option.weight])
	
	var _types = types.duplicate()
	_types.sort_custom(func(a, b): return options[a].weight > options[b].weight)
	_types = _types.filter(func (a): return options[a].weight == options[_types[0]].weight)
	
	var restult = _types.pick_random()
	if dancefloor_.club.order == "first":
		print([_types, restult])
	return restult
	
func apply_crystals(dancefloor_: Dancefloor, crystals_: Array, type_: String) -> void:
	var indexs = get(type_ + "_indexs")
	
	for _i in indexs.size():
		var crystal = crystals_[_i]
		var bridge = dancefloor_.bridges.get_child(indexs[_i])
		var charge = floor(crystal.volume / bridge.length)
		
		for platform in bridge.platforms:
			platform.roll_mana_increment(charge)
