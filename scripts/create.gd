extends Node

@onready var bg = get_node("../Background")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not bg.visible:
		var FX := get_node("../CBFX") as SpinBox
		var info := get_node("../Info") as Sprite2D
		var FY := get_node("../CBFY") as SpinBox
		var PBN := get_node("../PlayBoard") as Node2D
		var CBN := get_node("../CreateBoard") as Node2D
		var config := get_node("../Settings Icon") as StaticBody2D
		FX.show()
		FY.show()
		PBN.hide()
		CBN.show()
		info.hide()
		config.hide()
