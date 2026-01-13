extends Area2D

@onready var pb = get_node("../PlayBoard")
@onready var oF = get_node("../OpenFile")

@onready var cb = get_node("../CreateBoard")
@onready var sF = get_node("../SaveFile")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if pb.visible:
			oF.visible = true
		if cb.visible:
			sF.visible = true
