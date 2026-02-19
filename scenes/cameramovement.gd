extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event) -> void:
	if event.is_action("movedown"):
		self.position.y += 10
	if event.is_action("moveup"):
		self.position.y -= 10
	if event.is_action("moveleft"):
		self.position.x -= 10
	if event.is_action("moveright"):
		self.position.x += 10
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
