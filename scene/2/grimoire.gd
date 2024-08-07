class_name Grimoire extends PanelContainer


@export var club: Club
@export var resource: GrimoireResource


func _ready() -> void:
	resource = GrimoireResource.new()
	init_basic_spells()
	update_variations()
	
func init_basic_spells() -> void:
	#var lengths = [50,70,80,100,140,160]
	var lengths = {}
	
	for bridge in club.dancefloor.bridges.get_children():
		if !lengths.has(bridge.length):
			lengths[bridge.length] = []
		
		lengths[bridge.length].append(bridge)
	
	var keys = lengths.keys()
	keys.sort()
	
	for key in keys:
		var spell_resource = SpellResource.new()
		spell_resource.bridge_length = key
		
		for bridge in lengths[key]:
			spell_resource.bridge_indexs.append(bridge.index)
		
		resource.spells.append(spell_resource)
	
func update_variations() -> void:
	for spell_resource in resource.spells:
		spell_resource.init_variations(club.dancefloor)
