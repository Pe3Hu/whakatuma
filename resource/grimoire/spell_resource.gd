class_name SpellResource extends Resource


@export_enum("offense", "defense") var role: String
@export var bridge_indexs: Array[int]
@export var bridge_length: int
@export var variations: Array[VariationResource]


func init_variations(dancefloor_: Dancefloor) -> void:
	for index in bridge_indexs:
		var bridge = dancefloor_.bridges.get_child(index)
		var variation_resource = VariationResource.new()
		variation_resource.bridge_index = index
		
		for platform in bridge.platforms:
			variation_resource.manas.append(platform.mana)
			variation_resource.mana_sum += platform.mana
