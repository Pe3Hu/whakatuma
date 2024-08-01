class_name Ramification extends Polygon2D


@export var framedRamification: FramedRamification
@export var graph: Graph:
	set(graph_):
		graph = graph_
		
		init_vertexs()
		index = int(Global.num.index.ramification)
		Global.num.index.ramification += 1
	get:
		return graph
@export var platform_index: int:
	set(platform_index_):
		platform_index = platform_index_
		
		for order in Global.arr.order:
			var club = graph.judge.get(order)
			var platform = club.dancefloor.platforms.get_child(platform_index_)
			platforms.append(platform)
			powers += platform.power
		
		framedRamification.ramification = self
	get:
		return platform_index

var grid: Vector2i
var index: int
var platforms: Array
var powers: int = 0


func init_vertexs() -> void:
	position.x += graph.ramification_size.x / 2
	var vertexs = []
	
	for direction in Global.dict.direction.diagonal:
		var vertex = Vector2(direction) * graph.ramification_size / 2
		vertexs.append(vertex)
	
	set_polygon(vertexs)
	framedRamification.position -= framedRamification.custom_minimum_size / 2
