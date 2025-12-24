extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_file_selected(path: String) -> void:
	get_node("../PlayBoard").createBoard(path)
	pass # Replace with function body.
