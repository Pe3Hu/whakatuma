class_name Club extends PanelContainer


@export var arena: Arena:
	set(arena_):
		arena = arena_
		
		if arena.clubs.get_child_count() == 1:
			order = "first"
		else:
			order = "second"
		
		#arena.judge.set(order, self)
	get:
		return arena
@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
	get:
		return dancefloor
@export var grimoire: Grimoire
@export_enum("first", "second") var order: String:
	set(order_):
		order = order_
		
		var style = StyleBoxFlat.new()
		style.bg_color = Global.color.club[order]
		dancefloor.set("theme_override_styles/panel", style)
		try_cultivation()
	get:
		return order


func _ready() -> void:
	pass
	
func try_cultivation() -> void:
	var crystals = []
	
	for _i in 2:
		var crystal_resource = CrystalResource.new()
		crystal_resource.type = "blood"
		crystal_resource.volume = 200
		crystals.append(crystal_resource)
	
	var cultivation_resource = load("res://resource/cultivation/2.tres")
	
	for _i in 3:
		var type = cultivation_resource.get_best_type(dancefloor, crystals)
		cultivation_resource.apply_crystals(dancefloor, crystals, type)
	
func cultivate_spiral(cultivation_: CultivationResource, crystals_: Array) -> void:
	pass
