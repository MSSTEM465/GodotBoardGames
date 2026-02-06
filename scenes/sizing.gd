extends Area2D

@onready var board = get_node("../../theGame")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		board.create(50,50)
		get_node("../ProgressBar").show()
		self.hide()
		get_node("../Larger").hide()


func _on_larger_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		board.create(100,100)
		get_node("../ProgressBar").show()
		get_node("../Larger").hide()
		get_node("../Smaller").hide()
