extends Area2D
# MINESWEEPER
var on = preload("res://images/minesweeper/x.png")
var off = preload("res://images/minesweeper/0.png")
@onready var field = get_node("../field")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if field.antiGuess:
			get_node("Sprite2D").texture = off
		else:
			get_node("Sprite2D").texture = on
		field.antiGuess = not field.antiGuess
	pass # Replace with function body.
