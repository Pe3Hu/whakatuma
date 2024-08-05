class_name RamificationResource extends Resource


@export var graph: GraphResource
@export var iteration: IterationResource
@export var parents: Array[RamificationResource]:
	set(parents_):
		parents = parents_
		
		if !parents.is_empty():
			graph.add_branch(parents.back(), self)
			
			if parents.back().is_root:
				is_root = true
				is_clone = true
			else:
				var unvisited_platforms = get_next_platform_indexs()
				
				if unvisited_platforms.is_empty():
					is_root = true
	get:
		return parents

var platforms: Array
var childs: Array[RamificationResource]
var branchs: Dictionary
var grid: Vector2i

var first_power: int
var second_power: int
var sum_power: int
var first_proportion: int
var second_proportion: int

var is_root: bool = false
var is_swallowed: bool = false
var is_clone: bool = false


func get_next_platform_indexs() -> Array:
	return Global.dict.platform.index[platforms.back()].platforms.filter(func (a): return !platforms.has(a)).filter(func (a): return !graph.obstacles.has(a))
	
