class_name Arena extends PanelContainer


@export var world: World
@export var judge: Judge
@export var clubs: VBoxContainer

@onready var club_scene = preload("res://scene/2/club.tscn")


func _ready() -> void:
	init_clubs()
	judge.roll_root()
	
func init_clubs() -> void:
	for _i in 2:
		add_club()
	
func add_club() -> void:
	var club = club_scene.instantiate()
	clubs.add_child(club)
	club.arena = self
