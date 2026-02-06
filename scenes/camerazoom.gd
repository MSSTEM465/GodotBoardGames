extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_value_changed(value: float) -> void:
	get_node("../../Camera2D").zoom.x = self.value
	get_node("../../Camera2D").zoom.y = self.value
	pass # Replace with function body.
