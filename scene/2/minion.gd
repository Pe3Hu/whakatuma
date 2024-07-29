class_name Minion extends CharacterBody2D


@export var arena: Arena
@export var platform: Platform:
	set(platform_):
		if platform != null:
			pass
		
		platform = platform_
		position = platform.position
	get:
		return platform
