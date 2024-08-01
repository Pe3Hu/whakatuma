class_name Graph extends Node2D


@export var judge: Judge
@export var ramifications: Node2D
@export var branchs: Node2D

@onready var ramification_scene = preload("res://scene/3/ramification.tscn")
@onready var branch_scene = preload("res://scene/3/branch.tscn")

var layers = {}
var grid = Vector2i()

const offset_ramification = 240
const ramification_size = Vector2(90, 45)
const branch_width = 10


func add_ramification(platform_index_: int) -> void:
	var ramification = ramification_scene.instantiate()
	ramification.graph = self
	#ramification.position = Vector2()
	ramification.grid = Vector2i(grid)
	ramification.platform_index = platform_index_
	ramifications.add_child(ramification)
	
	if !layers.has(grid.x):
		layers[grid.x] = []
	
	layers[grid.x].append(ramification)
