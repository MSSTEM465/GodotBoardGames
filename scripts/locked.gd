extends Sprite2D # NONOGRAM


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.get_name() == "Web": # Will disable play mode on Web release
		self.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
