class_name Dancefloor extends PanelContainer


@export var resource: DispositionResource:
	set(resource_):
		resource = resource_
		
		update_platform_manas()
	get:
		return resource
@export var club: Club:
	set(club_):
		club = club_
	get:
		return club
@export var nodes: Node2D
@export var platforms: Node2D
@export var bridges: Node2D
@export var sectors: Node2D

@onready var platform_scene = preload("res://scene/1/platform.tscn")
@onready var bridge_scene = preload("res://scene/1/bridge.tscn")
@onready var sector_scene = preload("res://scene/1/sector.tscn")

var segments: Dictionary
var lengths: Dictionary

const offset_platform = 240
const platform_extent = 15
const bridge_width = 10


func _ready() -> void:
	custom_minimum_size = Vector2(offset_platform * sqrt(3), offset_platform * 2)
	nodes.position = custom_minimum_size / 2 + Vector2.ONE * platform_extent
	custom_minimum_size.y = offset_platform * 1.5
	custom_minimum_size += Vector2.ONE * platform_extent * 2
	
	Global.num.index.platform = 0
	Global.num.index.bridge = 0
	Global.num.index.sector = 0
	
	init_platforms()
	init_bridges()
	init_sectors()
	
	var _resource = DispositionResource.new()
	#_resource.manas = [5,4,4,3,3,3,2,2,2,2,1,1,1,1,1]
	_resource.manas = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	resource = _resource
	
func init_platforms() -> void:
	for _i in 4:
		segments[int(_i + 1)] = []
	
	init_primary_platforms()
	init_secondary_platforms()
	init_quaternary_platforms()
	
func init_primary_platforms() -> void:
	var corners = 3
	var type = "even"
	var vectors = Global.dict.corner.vector[corners][type]
	var segment = 1
	
	for vector in vectors:
		add_platform(segment, vector * offset_platform)
	
func init_secondary_platforms() -> void:
	var _segments = [2, 3]
	
	for segment in _segments:
		for _i in segments[1].size():
			var a = segments[1][_i]
			var _j = (_i + 1) % segments[1].size()
			var b = segments[1][_j]
			
			for _k in segment - 1:
				add_part(segment, a, b, _k + 1)
	
func init_quaternary_platforms() -> void:
	var segment = 4
	
	for _i in segments[1].size():
		var a = segments[1][_i]
		var _j = ((_i + 1) * 2 + 1) % segments[3].size()
		var b = segments[3][_j]
		add_bridge(a, b)
	
	for _i in bridges.get_child_count():
		var _j = (_i + 1) % bridges.get_child_count()
		var a = bridges.get_child(_i)
		var b = bridges.get_child(_j)
		var vector = get_cross_bridges(a, b)
		add_platform(segment, vector)
	
func add_platform(segment_: int, vector_: Vector2) -> void:
	var platform = platform_scene.instantiate()
	platform.dancefloor = self
	platform.position = vector_
	platform.segment = segment_
	platforms.add_child(platform)
	segments[segment_].append(platform)
	
func add_part(segment_: int, a_: Platform, b_: Platform, step_: int) -> void:
	var vector = (a_.position - b_.position).normalized()
	vector *= (a_.position - b_.position).length() / segment_ * step_
	vector += b_.position
	add_platform(segment_, vector)
	
func add_bridge(a_: Platform, b_: Platform) -> void:
	var bridge = bridge_scene.instantiate()
	bridges.add_child(bridge)
	bridge.dancefloor = self
	bridge.platforms = [a_, b_]
	
func get_cross_bridges(a_: Bridge, b_: Bridge) -> Vector2:
	var a = a_.platforms[0].position
	var b = a_.platforms[1].position
	var c = b_.platforms[0].position
	var d = b_.platforms[1].position
	return Global.cross_4_points(a, b, c, d)
	
func init_bridges() -> void:
	while bridges.get_child_count() > 0:
		var bridge = bridges.get_child(0)
		bridges.remove_child(bridge)
	
	var _strips = [
		[
			[1, 0, 3, 1],
			[3, 1, 2, 0],
			[2, 0, 3, 0],
			[3, 0, 1, 1]
		],
		[
			[1, 1, 3, 3],
			[3, 3, 2, 1],
			[2, 1, 3, 2],
			[3, 2, 1, 2],
		],
		[
			[1, 2, 3, 5],
			[3, 5, 2, 2],
			[2, 2, 3, 4],
			[3, 4, 1, 0],
		],
		[
			[1, 0, 4, 2],
			[4, 2, 4, 0],
			[4, 0, 3, 3]
		],
		[
			[1, 1, 4, 0],
			[4, 0, 4, 1],
			[4, 1, 3, 5]
		],
		[
			[1, 2, 4, 1],
			[4, 1, 4, 2],
			[4, 2, 3, 1]
		],
		[
			[2, 2, 4, 1],
			[4, 1, 3, 2]
		],
		[
			[2, 1, 4, 0],
			[4, 0, 3, 0]
		],
		[
			[2, 0, 4, 2],
			[4, 2, 3, 4]
		]
	]
	
	Global.num.index.bridge = 0
	
	for indexs in _strips:
		add_strip(indexs)
	
func add_strip(indexs_: Array) -> void:
	for indexs in indexs_:
		var a = segments[indexs[0]][indexs[1]]
		var b = segments[indexs[2]][indexs[3]]
		add_bridge(a, b)
	
func init_sectors() -> void:
	var _sectors = [
		[
			[12, 0, 20],
			[12, 25, 11]
		],
		[
			[15, 4, 14],
			[15, 23, 3]
		],
		[
			[18, 8, 17],
			[18, 21, 7]
		],
		[
			[26, 20, 1],
			[26, 2, 23, 13]
		],
		[
			[24, 14, 5],
			[24, 6, 21, 16]
		],
		[
			[22, 17, 9],
			[22, 10, 25, 19]
		],
		[
			[13, 16, 19]
		]
	]
	
	for indexs in _sectors:
		add_sector(indexs)
	
func add_sector(indexs_: Array) -> void:
	for indexs in indexs_:
		var _brigdes = []
		
		for index in indexs:
			var brigde = bridges.get_child(index)
			_brigdes.append(brigde)
		
		var sector = sector_scene.instantiate()
		sectors.add_child(sector)
		sector.dancefloor = self
		sector.bridges = _brigdes
	
func update_platform_manas() -> void:
	for _i in resource.indexs.size():
		var index = resource.indexs[_i]
		var platform = platforms.get_child(index)
		platform.mana = resource.manas[_i]
