class_name IterationResource extends Resource


@export var graph: GraphResource
@export_enum("second", "first") var order: String
@export var col: int:
	set(col_):
		col = col_
		graph.cols[col] = self
		
		match col % 2:
			0:
				order = "second"
			1:
				order = "first"
	get:
		return col

var branchs: Array[BranchResource]
var ramifications: Array[RamificationResource]


func add_ramification(ramification_: RamificationResource) -> void:
	ramifications.append(ramification_)
	ramification_.iteration = self
