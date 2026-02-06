extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../../theGame").simulating = true
		get_node("../Restart").show()
		self.hide()


func _on_restart_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../../theGame").simulating = false
		for i in get_node("../../theGame").get_children():
			i.queue_free()
		get_node("../Larger").show()
		get_node("../Smaller").show()
		get_node("../Restart").hide()
