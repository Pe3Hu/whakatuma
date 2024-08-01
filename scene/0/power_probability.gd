class_name PowerProbability extends PanelContainer


@export var club: Club:
	set(club_):
		club = club_
		
		init_labels_text()
		var style = StyleBoxFlat.new()
		style.bg_color = Global.color.club[club.order]
		set("theme_override_styles/panel", style)
	get:
		return club
@export var framed_ramification: FramedRamification:
	set(framed_ramification_):
		framed_ramification = framed_ramification_
	get:
		return framed_ramification
@export var power: Label
@export var probability: Label


func init_labels_text() -> void:
	var _i = Global.arr.order.find(club.order)
	var platform = framed_ramification.ramification.platforms[_i]
	power.text = str(platform.power)
	probability.text = str(platform.power * 100 / framed_ramification.ramification.powers) + "%"
