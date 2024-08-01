class_name Platform extends Polygon2D


@export var indexLabel: FramedLabel
@export var powerLabel: FramedLabel
@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
		
		init_labels()
		init_vertexs()
	get:
		return dancefloor
@export var segment: int:
	set(segment_):
		segment = segment_
		
		color = Global.color.platform[str(segment)]
	get:
		return segment
@export var index: int:
	set(index_):
		index = index_
		indexLabel.resource.value = index
		indexLabel.update_label()
	get:
		return index
@export var power: int:
	set(power_):
		power = power_
		powerLabel.resource.value = power
		powerLabel.update_label()
	get:
		return power


func init_labels() -> void:
	var keys = ["index", "power"]
	
	for key in keys:
		var label = get(key + "Label")
		var resource = TripletResource.new()
		resource.type = "frame"
		resource.subtype = "bridge"
		resource.value = 0
		label.set_resource(resource)
		label.position -= indexLabel.max_size / 2
	
	index = int(Global.num.index.platform)
	Global.num.index.platform += 1
	
func init_vertexs() -> void:
	var vertexs = []
	
	for direction in Global.dict.direction.linear2:
		var vertex = Vector2(direction) * dancefloor.platform_extent
		vertexs.append(vertex)
	
	set_polygon(vertexs)
	
