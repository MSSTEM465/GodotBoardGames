extends Timer # KNUCKLEBONES


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void: # After game completion, wait a few seconds, and start anew.
	get_node("../North Board").generate()
	get_node("../South Board").generate()
	pass # Replace with function body.
