extends Node

@onready var background = get_node("../Background")
@onready var pb = get_node("../PlayBoard")
@onready var config = get_node("../Config")
@onready var exit = get_node("../Exit")
@onready var b1 = get_node("../AF Button")
@onready var b2 = get_node("../Correction")
@onready var b3 = get_node("../Penalize")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		config.show()
		background.show()
		exit.show()
		b1.show()
		b2.show()
		if pb.correction:
			b3.show()
