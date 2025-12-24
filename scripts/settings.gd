extends Node

@onready var af = get_node("../AF Button")
@onready var playBoard = get_node("../PlayBoard")
@onready var penalize = get_node("../Penalize")
@onready var correction = get_node("../Correction")
@onready var empty = load("res://images/empty.png")
@onready var marked = load("res://images/marked.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self == af:
			var sprite = get_node("empty")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.autofill = true
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.autofill = false
		if self == correction:
			var sprite = get_node("empty")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.correction = true
				penalize.show()
				
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.correction = false
				penalize.hide()
		if self == penalize:
			var sprite = get_node("empty")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.penalize = true
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.penalize = false
		
	pass # Replace with function body.
