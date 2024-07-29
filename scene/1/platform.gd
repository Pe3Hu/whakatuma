class_name Platform extends Polygon2D


@export var dancefloor: Dancefloor:
	set(dancefloor_):
		dancefloor = dancefloor_
		
		init_vertexs()
	get:
		return dancefloor

const a = 16


func init_vertexs() -> void:
	var vertexs = []
	
	for direction in Global.dict.direction.linear2:
		var vertex = Vector2(direction) * a
		vertexs.append(vertex)
	
	set_polygon(vertexs)
