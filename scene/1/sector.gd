class_name Sector extends Polygon2D


@export var framedLabel: FramedLabel
@export var platforms: Array[Platform]
@export var bridges: Array:
	set(bridges_):
		bridges = bridges_
		
		init_platforms()
	get:
		return bridges
@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
		
		var resource = TripletResource.new()
		resource.type = "frame"
		resource.subtype = "bridge"
		resource.value = Global.num.index.sector
		framedLabel.set_resource(resource)
		
		index = int(Global.num.index.sector)
		Global.num.index.sector += 1
	get:
		return dancefloor

var index: int


func init_platforms() -> void:
	var vertexs = []
	
	for bridge in bridges:
		for platform in bridge.platforms:
			if !platforms.has(platform):
				platforms.append(platform)
				vertexs.append(platform.position)
				framedLabel.position += platform.position
	
	framedLabel.position /= platforms.size()
	framedLabel.position -= framedLabel.max_size / 2
	color = Color.from_hsv(float(index) / 13, 1.0, 1.0)
	set_polygon(vertexs)
