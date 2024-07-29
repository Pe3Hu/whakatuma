class_name Bridge extends Line2D


@export var framedLabel: FramedLabel
@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
		
		var resource = TripletResource.new()
		resource.type = "frame"
		resource.subtype = "bridge"
		resource.value = Global.num.index.bridge
		framedLabel.set_resource(resource)
		
		index = int(Global.num.index.bridge)
		Global.num.index.bridge += 1
	get:
		return dancefloor

@export var platforms: Array:
	set(platforms_):
		platforms = platforms_
		
		init_vertexs()
	get:
		return platforms

var index: int
var length: int


func init_vertexs() -> void:
	for platform in platforms:
		var vertex = platform.position
		add_point(vertex)
		framedLabel.position += vertex
	
	framedLabel.position /= platforms.size()
	framedLabel.position -= framedLabel.max_size / 2
	default_color = Color.from_hsv(float(index) / 30, 1.0, 1.0)
	
	length = round(platforms[0].position.distance_to(platforms[1].position) / 10) * 10
	
	if !dancefloor.lengths.has(length):
		dancefloor.lengths[length] = []
	
	dancefloor.lengths[length].append(self)
