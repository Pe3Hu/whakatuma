class_name BranchPrize extends PanelContainer


@export var branch: Branch:
	set(branch_):
		branch = branch_
		#init_labels_text()
	get:
		return branch
@export var index: Label
@export var prize: Label

const max_size = Vector2(30, 40)


func init_labels_text() -> void:
	index.text = str(branch.index)
	prize.text = str(branch.prize)#.pad_decimals(2)
	var style = StyleBoxFlat.new()
	
	if branch.prize > 0:
		style.bg_color = Global.color.club["first"]
	if branch.prize < 0:
		style.bg_color = Global.color.club["second"]
	
	if branch.prize != 0:
		set("theme_override_styles/panel", style)
