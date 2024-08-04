class_name FramedRamification extends PanelContainer


@export var ramification: Ramification:
	set(ramification_):
		ramification = ramification_
		init_powers()
		indexRamification.text = str(ramification.index)
		indexPlatform.text = str(ramification.platform_index)
	get:
		return ramification
@export var first: PowerProbability
@export var second: PowerProbability
@export var indexRamification: Label
@export var indexPlatform: Label


func init_powers() -> void:
	for order in Global.arr.order:
		var powerProbability = get(order)
		powerProbability.club = ramification.graph.judge.get(order)
	
func set_bg_color(color_: Color) -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = color_
	set("theme_override_styles/panel", style)
