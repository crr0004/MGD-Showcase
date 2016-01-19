
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

export(NodePath) var playerPath

var p0 = Vector2(0,0)
var p1 = Vector2(0,100)
var p2 = Vector2(100,0)
var p3 = Vector2(100,100)
var segments = 100.0

var player

func _ready():
	# Initialization here
	set_fixed_process(true)
	player = get_node(playerPath)
	p0 = get_node("p0").get_pos()
	p1 = get_node("p1").get_pos()
	p2 = get_node("p2").get_pos()
	p3 = get_node("p3").get_pos()
	p3 = get_node("p3").get_pos()
	
	
	


func _draw():

	#draw_line(Vector2(0,0) * 10, Vector2(1,1) * 10, Color(1,1,1), 1)

	var q = CalcBezierPoint(0)
	for i in range(segments):
		var t = i / segments
		var q1 = CalcBezierPoint(t)
		draw_line(q, q1, Color(1, 1, 1), 1)
		q = q1
		
func CalcBezierPoint(t):
	var u = 1 - t
	var tt = t*t
	var uu = u * u
	var uuu = uu * u
	var ttt = tt * t
	
	var p = uuu * p0
	p += 3 * uu * t * p1
	p += 3 * u * tt * p2
	p += ttt * p3
	
	return p
