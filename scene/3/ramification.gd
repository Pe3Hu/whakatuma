class_name Ramification extends Polygon2D


@export var framedRamification: FramedRamification
@export var graph: Graph:
	set(graph_):
		graph = graph_
		
		init_vertexs()
		index = int(Global.num.index.ramification)
		Global.num.index.ramification += 1
		unvisited_platforms.append_array(Global.dict.platform.index.keys())
	get:
		return graph
@export var previous_ramification: Ramification:
	set(previous_ramification_):
		previous_ramification = previous_ramification_
		
		if previous_ramification != null:
			for index in previous_ramification.visited_platforms:
				set_platform_index_as_visited(index)
	get:
		return previous_ramification
@export var platform_index: int:
	set(platform_index_):
		platform_index = platform_index_
		
		for order in Global.arr.order:
			var club = graph.judge.get(order)
			var platform = club.dancefloor.platforms.get_child(platform_index_)
			platforms.append(platform)
			powers += platform.power
		
		framedRamification.ramification = self
		set_platform_index_as_visited(platform_index)
	get:
		return platform_index

var grid: Vector2i
var index: int
var platforms: Array
var powers: int = 0
var visited_platforms = []
var unvisited_platforms = []


func init_vertexs() -> void:
	position.x += graph.ramification_size.x / 2
	var vertexs = []
	
	for direction in Global.dict.direction.diagonal:
		var vertex = Vector2(direction) * graph.ramification_size / 2
		vertexs.append(vertex)
	
	set_polygon(vertexs)
	framedRamification.position -= framedRamification.custom_minimum_size / 2
	
func set_platform_index_as_visited(index_: int) -> void:
	if unvisited_platforms.has(index_):
		unvisited_platforms.erase(index_)
	
	if !visited_platforms.has(index_):
		visited_platforms.append(index_)
	
func get_next_platform_indexs() -> Array:
	return Global.dict.platform.index[platform_index].platforms.filter(func (a): return unvisited_platforms.has(a))
