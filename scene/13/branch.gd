class_name Branch extends Line2D



@export var branchPrize: BranchPrize
@export var graph: Graph:
	set(graph_):
		graph = graph_
		index = int(Global.num.index.branch)
		Global.num.index.branch += 1
	get:
		return graph
@export var ramifications: Array:
	set(ramifications_):
		ramifications = ramifications_
		
		if !ramifications[0].is_root:
			branchPrize.branch = self
			update_vertexs()
			calc_prize()
		#else:
		#	visible = false
	get:
		return ramifications
@export var prize: float = 0:
	set(prize_):
		prize = prize_
		branchPrize.init_labels_text()
	get:
		return prize
@export var is_swallowed: bool = false:
	set(is_swallowed_):
		is_swallowed = is_swallowed_
		visible = !is_swallowed
	get:
		return is_swallowed

var index: int

func update_vertexs() -> void:
	var step = 2
	clear_points()
	var a = ramifications[0].position
	var b = ramifications[1].position
	var c = Vector2(a.x + graph.ramification_size.x / step, a.y)
	var d = Vector2(a.x + graph.ramification_size.x / step, b.y)
	#var c = Vector2(a.x + (b.x - a.x) / step, a.y)
	#var d = Vector2(a.x + (b.x - a.x) / step, b.y)
	var vertexs = [a, c, d, b]
	
	for vertex in vertexs:
		add_point(vertex)
	
	branchPrize.position = Vector2(d.x - (c.x - (b.x - graph.ramification_size.x / step)) / step, b.y)
	branchPrize.position -= branchPrize.max_size / step
	
func calc_prize() -> void:
	prize = 0
	var ramification = ramifications[1]
	
	for order in Global.arr.order:
		var proportion = ramification.framedRamification.get(order).proportion
		
		match order:
			"second":
				proportion *= -1
		
		prize += proportion
	
func crush() -> void:
	for ramification in ramifications:
		ramification.branchs.erase(self)
	
	graph.branchs.remove_child(self)
	queue_free()
