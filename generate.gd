extends Area2D

@onready var CreateBoard = get_node("../CreateBoard")
@onready var VerLeng = get_node("../VerLeng")
@onready var HorLeng = get_node("../HorLeng")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		CreateBoard.generate([HorLeng.value,VerLeng.value])
	pass # Replace with function body.
