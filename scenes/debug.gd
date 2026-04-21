extends Area2D
@onready var hider = get_node("../Hider")
@onready var board = get_node("../Ship View")
@onready var peg = get_node("../peg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_node("../Wait").show()
		get_node("../Hider").hide()
		board.hide()
		get_node("../Map").hide()
		#await get_tree().process_frame
		#await get_tree().process_frame
		board.showP1()
		#await get_tree().process_frame
		#await get_tree().process_frame
		get_node("../Map").showP2()
		#await get_tree().process_frame
		#await get_tree().process_frame
		get_node("../Map").show()
		board.show()
		get_node("../Player").set_text("")
		get_node("../Label").set_text("Player 1")
		get_node("../Label2").set_text("Player 2")
		get_node("../Wait").hide()
		board.endGame = true
	pass # Replace with function body.
