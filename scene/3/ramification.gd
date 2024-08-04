class_name Ramification extends Polygon2D


@export var framedRamification: FramedRamification
@export var graph: Graph:
	set(graph_):
		graph = graph_
		framedRamification.custom_minimum_size = graph.ramification_size
		init_vertexs()
		index = int(Global.num.index.ramification)
		Global.num.index.ramification += 1
	get:
		return graph
@export var previous_ramification: Ramification:
	set(previous_ramification_):
		previous_ramification = previous_ramification_
		unvisited_platforms = get_next_platform_indexs()
		
		if previous_ramification != null:
			graph.add_branch(previous_ramification, self)
			
			if previous_ramification.is_root:
				is_root = true
				is_clone = true
				unvisited_platforms = []
			else:
				
				for _index in previous_ramification.visited_platforms:
					set_platform_index_as_visited(_index)
				
				if unvisited_platforms.is_empty():
					is_root = true
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
@export var is_root: bool = false:
	set(is_root_):
		is_root = is_root_
		
		if is_root:
			var bg_color = Color.from_hsv(0, 0, 0, 0.2)
			framedRamification.set_bg_color(bg_color)
	get:
		return is_root
@export var is_swallowed: bool = false:
	set(is_swallowed_):
		is_swallowed = is_swallowed_
		visible = !is_swallowed
	get:
		return is_swallowed

var iteration: Iteration
var grid: Vector2i
var index: int
var platforms: Array
var powers: int = 0
var visited_platforms = []
var unvisited_platforms = []
var branchs: Dictionary
var next_ramifications: Array[Ramification]
var is_clone: bool = false


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
	return Global.dict.platform.index[platform_index].platforms.filter(func (a): return !visited_platforms.has(a)).filter(func (a): return !graph.obstacles.has(a))
	
func swallow_next_ramifications() -> void:
	var prizes = []
	var previous_branch
	
	for branch in branchs:
		if next_ramifications.has(branchs[branch]):
			branchs[branch].is_swallowed = true
			branch.is_swallowed = true
			prizes.append(branch.prize)
		else:
			previous_branch = branch
	
	match iteration.order:
		"first":
			prizes.sort_custom(func(a, b): return a < b)
		"second":
			prizes.sort_custom(func(a, b): return a > b)
	
	previous_branch.prize += prizes[0]
	
func crush() -> void:
	iteration.ramifications.erase(self)
	previous_ramification.next_ramifications.erase(self)
	
	for branch in branchs:
		branch.crush()
	
	graph.ramifications.remove_child(self)
	queue_free()
	#Global.num.index.ramification -= 1
