class_name GraphResource extends Resource


var iterations: Array[IterationResource]
var ramifications: Array[RamificationResource]
var branchs: Array[BranchResource]

var cols = {}
var origin: int
var grid: Vector2i
var obstacles: Array
var dispositions: Dictionary


func set_obstacles(obstacles_: Array) -> GraphResource:
	obstacles = obstacles_
	return self
	
func set_origin(origin_: int) -> GraphResource:
	origin = origin_
	return self
	
func set_dispositions(dispositions_: Dictionary) -> GraphResource:
	dispositions = dispositions_
	return self
	
func init() -> void:
	add_origin_branch()
	pass
	
func add_origin_branch() -> void:
	add_ramification(-1, null)
	var a = cols[grid.x].ramifications.front()
	grid.y = 0
	grid.x += 1
	add_ramification(origin, a)
	var b = cols[grid.x].ramifications.front()
	pass
	
func add_ramification(platform_: int, parent_: RamificationResource) -> void:
	if !cols.has(grid.x):
		add_iteration(grid.x)
	
	var ramification = RamificationResource.new()
	ramification.graph = self
	ramification.grid = Vector2i(grid)
	var parents: Array[RamificationResource]
	
	if parent_ != null:
		parents.append_array(parent_.parents)
		parents.append(parent_)
		ramification.platforms.append_array(parent_.platforms)
	
	if platform_ != -1:
		ramification.platforms.append(platform_)
	
	ramification.parents = parents
	
	ramifications.append(ramification)
	cols[grid.x].add_ramification(ramification)
	grid.y += 1
	
func add_branch(a_: RamificationResource, b_: RamificationResource) -> void:
	var branch = BranchResource.new()
	branch.graph = self
	branch.ramifications = [a_, b_]
	branchs.append(branch)
	a_.branchs[branch] = b_
	b_.branchs[branch] = a_
	a_.childs.append(b_)
	
func add_iteration(col_: int) -> void:
	var iteration = IterationResource.new()
	iteration.graph = self
	iteration.col = col_
	iterations.append(iteration)
	
func next_iteration() -> void:
	var last_col = cols.keys().back()
	var iteration = cols[last_col]
	
	var all_roots = true
	
	for ramification in iteration.ramifications:
		if !ramification.is_root:
			all_roots = false
			break
	
	if !all_roots:
		grid.x += 1
		grid.y = 0
		
		for ramification in iteration.ramifications:
			if !ramification.is_root:
				var indexs = ramification.get_next_platform_indexs().filter(func (a): return !obstacles.has(a))
				
				for index in indexs:
					add_ramification(index, ramification)
			else:
				add_ramification(ramification.platform_index, ramification)
