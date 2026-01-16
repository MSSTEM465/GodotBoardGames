extends Area2D
@onready var easy = get_node("../Easy")
@onready var medium = get_node("../Medium")
@onready var hard = get_node("../Hard")
@onready var field = get_node("../../field")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self == easy:
			field.generateBoard([9,9],10)
		if self == medium:
			field.generateBoard([16,16],40)
		if self == hard:
			field.generateBoard([16,30],99)
	pass # Replace with function body.
