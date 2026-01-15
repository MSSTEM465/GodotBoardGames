extends Area2D

@onready var nonogram = get_node("../Nonogram")
@onready var Reversi = get_node("../Reversi")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self == nonogram:
			get_tree().change_scene_to_file("res://scenes/gameplay.tscn")
		if self == Reversi:
			get_tree().change_scene_to_file("res://scenes/reversi.tscn")
	pass # Replace with function body.
