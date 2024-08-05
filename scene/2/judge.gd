class_name Judge extends ScrollContainer


@export var control: Control
@export var arena: Arena:
	set(arena_):
		arena = arena_
	get:
		return arena
@export var graph: Graph:
	set(graph_):
		graph = graph_
	get:
		return graph

var first: Club
var second: Club
var max_row: int = 0
var swallow_col: int


func roll_root() -> void:
	var dispositions = {}
	
	for order in Global.arr.order:
		var club = get(order)
		dispositions[order] = club.dancefloor.resource
	
	var obstacles = [4, 7]
	var opitons = [14]
	var index = opitons.pick_random()
	
	graph.resource = GraphResource.new()
	graph.resource.set_dispositions(dispositions).set_obstacles(obstacles).set_origin(index).init()
	graph.add_ramification(index, null)
	
	for _i in 2:
		graph.next_iteration()
	
	align_graph()
	final_clean()
	#get_all_roots()
	#swallow_iterations()
	
func align_graph() -> void:
	var flag = false
	
	for col in range(graph.cols.keys().back(), -1, -1):
		graph.cols[col].align_previous_ramifications()
		
		if graph.cols[col].ramifications.size() > max_row:
			flag = true
			max_row = graph.cols[col].ramifications.size()
	
	if flag:
		control.custom_minimum_size.y = (max_row - 1) * graph.offset_ramification.y + graph.ramification_size.y # * 2
		#print(["max_row", max_row])
		control.custom_minimum_size.x = (graph.grid.x) * graph.offset_ramification.x + graph.ramification_size.x
		graph.position.y = control.custom_minimum_size.y / 2 + graph.offset_ramification.y / 2
	
func manual_iteration() -> void:
	graph.next_iteration()
	align_graph()
	
func erase_iteration() -> void:
	var col = graph.cols.keys().back()
	var iteration = graph.cols[col] 
	iteration.crush()
	graph.grid.x -= 1
	align_graph()
	
func final_clean() -> void:
	#for iteration in graph.iterations.get_children():
	for col in range(graph.grid.x, -1, -1):
		var iteration = graph.cols[col]
		var ramifications = iteration.ramifications.filter(func(a): return a.is_clone)
		
		for ramification in ramifications:
			ramification.crush()
	
func get_all_roots() -> void:
	var roots = []
	
	for iteration in graph.iterations.get_children():
		var ramifications = iteration.ramifications.filter(func(a): return a.is_root and !a.is_clone)
		roots.append_array(ramifications)
	
	print(graph.ramifications.get_child_count())
	#print(roots.size())
	
func swallow_iterations() -> void:
	swallow_col = graph.cols.keys().back()
	var stop = true
	
	while !stop:
		stop = swallow_last_iteration()
	
func swallow_last_iteration() -> bool:
	var iteration = graph.cols[swallow_col]
	
	var predestinations = iteration.ramifications.filter(func(a): return a.next_ramifications.size() == 1)
	var choices = iteration.ramifications.filter(func(a): return a.next_ramifications.size() > 1)
	
	for ramification in predestinations:
		ramification.swallow_next_ramifications()
	
	if !choices.is_empty():
		for ramification in choices:
			ramification.swallow_next_ramifications()
	
	swallow_col -= 1
	return !choices.is_empty()
	
func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_D:
				if event.is_pressed() && !event.is_echo():
					manual_iteration()
			KEY_A:
				if event.is_pressed() && !event.is_echo():
					erase_iteration()
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					swallow_last_iteration()
