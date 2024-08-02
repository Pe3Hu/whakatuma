class_name Graph extends Node2D


@export var judge: Judge
@export var ramifications: Node2D
@export var branchs: Node2D
@export var iterations: Node2D

@onready var ramification_scene = preload("res://scene/3/ramification.tscn")
@onready var branch_scene = preload("res://scene/3/branch.tscn")
@onready var iteration_scene = preload("res://scene/3/iteration.tscn")

var cols = {}
var grid = Vector2i(0, 0)

const offset_ramification = 240
const ramification_size = Vector2(90, 45)
const branch_width = 10


func add_ramification(platform_index_: int, previous_ramification_: Ramification) -> void:
	if !cols.has(grid.x):
		add_iteration(grid.x)
	
	var ramification = ramification_scene.instantiate()
	ramification.graph = self
	ramification.grid = Vector2i(grid)
	ramification.platform_index = platform_index_
	ramification.previous_ramification = previous_ramification_
	ramifications.add_child(ramification)
	cols[grid.x].add_ramification(ramification)
	grid.y += 1
	
func add_iteration(col_: int) -> void:
	var iteration = iteration_scene.instantiate()
	iteration.graph = self
	iteration.col = col_
	iterations.add_child(iteration)
	
func next_iteration() -> void:
	var last_col = cols.keys().back()
	var iteration = cols[last_col]
	
	for ramification in iteration.ramifications:
		var indexs = ramification.get_next_platform_indexs()
		
		for index in indexs:
			add_ramification(index, ramification)
	
	grid.x += 1
	grid.y = 0
