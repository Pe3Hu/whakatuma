class_name FramedLabel extends PanelContainer


@export var resource: TripletResource
@export var frame: TextureRect
@export var first: Label

const max_size = Vector2(32, 32)


func set_resource(resource_: TripletResource) -> void:
	resource = resource_
	update_ui()
	update_label()
	
func update_ui() -> void:
	var _path = resource.type
	var _name = resource.subtype
	
	if resource.type == "parameter":
		_name += " " + resource.measure
		
	frame.texture = load("res://asset/png/" + _path +  "/" + _name + ".png")
	
func update_label() -> void:
	first.text = str(resource.value)
