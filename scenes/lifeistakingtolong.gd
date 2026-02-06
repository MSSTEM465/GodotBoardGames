extends ProgressBar
@onready var board = get_node("../../theGame")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (len(get_node("../../theGame").board)) > 0:
		self.value = (len(board.get_children()) / (board.size * float(board.size))) * 100

		if self.value == 100:
			self.queue_free()
