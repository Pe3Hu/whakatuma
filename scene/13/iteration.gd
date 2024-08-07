class_name Iteration extends Polygon2D


@export var graph: Graph
@export var col: int:
	set(col_):
		col = col_
		graph.cols[col] = self
		position.x = graph.offset_ramification.x * (col)# + graph.ramification_size.x / 2
		
		match col % 2:
			0:
				order = "second"
			1:
				order = "first"
	get:
		return col
@export_enum("second", "first") var order: String:
	set(order_):
		order = order_
		color = Global.color.club[order]
	get:
		return order

var branchs: Array[Branch]
var ramifications: Array[Ramification]
var min_y
var max_y


func add_ramification(ramification_: Ramification) -> void:
	ramifications.append(ramification_)
	ramification_.iteration = self
	align_ramifications()
	
func align_ramifications() -> void:
	for _i in ramifications.size():
		var y = (-float(ramifications.size()) / 2 + _i) * graph.offset_ramification.y
		var x = col * graph.offset_ramification.x
		var ramification = ramifications[_i]
		ramification.position = Vector2(x, y)
		
		for branch in ramification.branchs:
			branch.update_vertexs()
	
func align_previous_ramifications() -> void:
	min_y = null#graph.judge.control.custom_minimum_size.y
	max_y = null#graph.judge.control.custom_minimum_size.y
	
	if col < graph.cols.keys().back():
		for ramification in ramifications:
			ramification.position.y = 0
			
			for next_ramification in ramification.next_ramifications:
				ramification.position.y += next_ramification.position.y
			
			ramification.position.y /= ramification.next_ramifications.size()
			
			if !ramification.is_clone:
				if min_y == null:
					min_y = ramification.position.y
				elif min_y > ramification.position.y:
					min_y = ramification.position.y
				
				if max_y == null:
					max_y = ramification.position.y
				elif max_y < ramification.position.y:
					max_y = ramification.position.y
			
			for branch in ramification.branchs:
				branch.update_vertexs()
	
		min_y -= graph.ramification_size.y * 0.5
		max_y += graph.ramification_size.y * 0.5
		init_vertexs()
	
func init_vertexs() -> void:
	if col > 0:
		var x = (graph.offset_ramification.x - graph.ramification_size.x / 2) / 2
		var a = Vector2(-graph.ramification_size.x / 2 - x, min_y)
		var b = Vector2(graph.ramification_size.x / 2, min_y)
		var c = Vector2(graph.ramification_size.x / 2, max_y)
		var d = Vector2(-graph.ramification_size.x / 2 - x, max_y)
		var vertexs = [a, b, c, d]
		set_polygon(vertexs)
	
func crush() -> void:
	#print(["ramifications", ramifications.size()])
	while !ramifications.is_empty():
		var ramification = ramifications[0]
		ramification.crush()
	
	graph.cols.erase(col)
	queue_free()
