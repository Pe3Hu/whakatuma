class_name Iteration extends Node2D


@export var graph: Graph
@export var branchs: Array[Branch]
@export var ramifications: Array[Ramification]
@export var col: int:
	set(col_):
		col = col_
		graph.cols[col] = self
	get:
		return col


func add_ramification(ramification_: Ramification) -> void:
	ramifications.append(ramification_)
	align_ramifications()
	
func align_ramifications() -> void:
	pass
