extends Node

var _following: Node2D = null
var _bounds: Rect2 = Rect2()

func follow(node: Node2D):
	_following = node

func set_bounds(bounds: Rect2):
	_bounds = bounds

func clear_bounds():
	set_bounds(Rect2())
