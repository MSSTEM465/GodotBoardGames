extends Area2D

var holdLeft = false
var holdRight = false
var holdUp = false
var holdDown = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if holdLeft:
		Input.action_press("moveleft")
	if holdRight:
		Input.action_press("moveright")
	if holdUp:
		Input.action_press("moveup")
	if holdDown:
		Input.action_press("movedown")
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if self == get_node("../left"):
				holdLeft = true
			if self == get_node("../right"):
				holdRight = true
			if self == get_node("../up"):
				holdUp = true
			if self == get_node("../down"):
				holdDown = true
		if event.is_released():
			if self == get_node("../left"):
				holdLeft = false
			if self == get_node("../right"):
				holdRight = false
			if self == get_node("../up"):
				holdUp = false
			if self == get_node("../down"):
				holdDown = false
	pass # Replace with function body.
