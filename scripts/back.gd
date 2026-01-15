extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../PlayBoard").niceOneIdiot()
		var Scroller = get_node("../Campaign")
		var Controller = Scroller.get_node("Control")
		self.hide()
		get_node("../Import and Export").show()
		get_node("../Import and Export/ImExport").texture = load("res://images/reset.png")
		Controller.inGame = false
		Scroller.show()
		pass # Replace with function body.
