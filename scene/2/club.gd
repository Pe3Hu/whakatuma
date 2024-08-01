class_name Club extends PanelContainer


@export var arena: Arena:
	set(arena_):
		arena = arena_
		
		if arena.clubs.get_child_count() == 1:
			order = "first"
		else:
			order = "second"
		
		arena.judge.set(order, self)
	get:
		return arena
@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
	get:
		return dancefloor
@export_enum("first", "second") var order: String:
	set(order_):
		order = order_
		
		var style = StyleBoxFlat.new()
		#get("theme_override_styles/panel")
		style.bg_color = Global.color.club[order]
		set("theme_override_styles/panel", style)
	get:
		return order

