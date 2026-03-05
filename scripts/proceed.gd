extends Area2D # BATTLESHIP
@onready var hider = get_node("../../Hider")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed: # Just hides the hider
		get_node("../../HiderAnimation").play("slideOut")
		get_node("../../peg").position = Vector2(9999,9999)
		if get_node("../../Ship View").preStage == false:
			get_node("../../Map").generate()
			get_node("../../Ship Selection").hide()
			get_node("../../Ship View").generateWithInfo()
		else:
			get_node("../../Ship View").generate()
