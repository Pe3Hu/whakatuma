class_name Sector extends Polygon2D


@export var IndexLabel: FramedLabel
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
		IndexLabel.set_resource(resource)
		
		index = int(Global.num.index.sector)
		Global.num.index.sector += 1
	get:
		return dancefloor

var index: int
var platforms: Array[Platform]


func init_platforms() -> void:
	var vertexs = []
	
	for bridge in bridges:
		for platform in bridge.platforms:
			if !platforms.has(platform):
				platforms.append(platform)
				vertexs.append(platform.position)
				IndexLabel.position += platform.position
	
	IndexLabel.position /= platforms.size()
	IndexLabel.position -= IndexLabel.max_size / 2
	color = Color.from_hsv(float(index) / 13, 1.0, 1.0)
	set_polygon(vertexs)
