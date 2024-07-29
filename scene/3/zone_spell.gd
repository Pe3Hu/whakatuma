class_name ZoneSpell extends Node2D


@export var arena: Arena
@export var currentPolygon: Polygon2D
@export var FinalPolygon: Polygon2D
@export var platform: Platform:
	set(platform_):
		if platform != null:
			pass
		
		platform = platform_
		position = platform.position
	get:
		return platform


func active() -> void:
	pass
