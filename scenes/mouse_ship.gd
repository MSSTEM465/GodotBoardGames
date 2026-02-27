extends Sprite2D # MINESWEEPER

var shipSelected = "None"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event) -> void:
	if event.is_action("export"): # E key. Will rotate the ship
		if event.pressed:
			print(self.rotation_degrees)
			if self.rotation_degrees == 0.0:
				self.rotation_degrees = 90
			elif self.rotation_degrees == 90.0:
				self.rotation_degrees = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
	pass
