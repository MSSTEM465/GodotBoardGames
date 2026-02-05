extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../Nonogram").hide()
		get_node("../Reversi").hide()
		get_node("../Minesweeper").hide()
		get_node("../Knucklebones").hide()
		get_node("../Battleship").hide()
		self.hide()
		get_node("../Credits").show()
	pass # Replace with function body.


func _on_back_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../Nonogram").show()
		get_node("../Reversi").show()
		get_node("../Minesweeper").show()
		get_node("../Knucklebones").show()
		get_node("../Battleship").show()
		self.show()
		get_node("../Credits").hide()
	pass # Replace with function body.
