class_name Arena extends Node2D


@export var world: World
@export var minions: Node2D
@export var spells: Node2D

@onready var minion_scene = preload("res://scene/2/minion.tscn")
@onready var zone_spell_scene = preload("res://scene/3/zone_spell.tscn")


func _ready() -> void:
	init_minions()
	init_spells()
	
func init_minions() -> void:
	var platform = world.dancefloor.segments[1][0]
	
	for _i in 1:
		add_minion(platform)
	
func add_minion(platform_: Platform) -> void:
	var minion = minion_scene.instantiate()
	minions.add_child(minion)
	minion.arena = self
	minion.platform = platform_
	
func init_spells() -> void:
	var platform = world.dancefloor.segments[2][0]
	
	for _i in 1:
		add_spell(platform)
	
func add_spell(platform_: Platform) -> void:
	var spell = zone_spell_scene.instantiate()
	spells.add_child(spell)
	spell.arena = self
	spell.platform = platform_
