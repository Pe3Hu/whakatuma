class_name Graph extends Node2D


@export var resource: GraphResource
@export var judge: Judge
@export var ramifications: Node2D
@export var branchs: Node2D
@export var iterations: Node2D

@onready var ramification_scene = preload("res://scene/13/ramification.tscn")
@onready var branch_scene = preload("res://scene/13/branch.tscn")
@onready var iteration_scene = preload("res://scene/13/iteration.tscn")

var cols = {}
var grid = Vector2i(0, 0)
var obstacles = [4, 7]

const offset_ramification = Vector2(120, 50)
const ramification_size = Vector2(80, 45)
const branch_width = 10


func _ready() -> void:
	position = ramification_size / 2
	
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
	
func add_branch(a_: Ramification, b_: Ramification) -> void:
	var branch = branch_scene.instantiate()
	branch.graph = self
	branch.ramifications = [a_, b_]
	branchs.add_child(branch)
	a_.branchs[branch] = b_
	b_.branchs[branch] = a_
	a_.next_ramifications.append(b_)
	
func add_iteration(col_: int) -> void:
	var iteration = iteration_scene.instantiate()
	iteration.graph = self
	iteration.col = col_
	iterations.add_child(iteration)
	
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
