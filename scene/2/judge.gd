class_name Judge extends PanelContainer


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


func roll_root() -> void:
	var opitons = [14]
	var index = opitons.pick_random()
	graph.add_ramification(index, null)
	graph.next_iteration()
