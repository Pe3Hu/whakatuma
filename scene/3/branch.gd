class_name Branch extends Line2D



@export var indexLabel: FramedLabel
@export var graph: Graph:
	set(graph_):
		graph = graph_
		
		var resource = TripletResource.new()
		resource.type = "frame"
		resource.subtype = "bridge"
		resource.value = Global.num.index.branch
		indexLabel.set_resource(resource)
		
		index = int(Global.num.index.branch)
		Global.num.index.branch += 1
	get:
		return graph
@export var ramifications: Array:
	set(ramifications_):
		ramifications = ramifications_
		init_vertexs()
	get:
		return ramifications

var index: int


func init_vertexs() -> void:
	for ramification in ramifications:
		var vertex = ramification.position
		add_point(vertex)
		indexLabel.position += vertex
	
	indexLabel.position /= ramifications.size()
	indexLabel.position -= indexLabel.max_size / 2
