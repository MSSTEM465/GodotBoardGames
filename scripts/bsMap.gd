extends Area2D

@onready var ships = get_node("../../Ship View")
@onready var peg = get_node("../../peg")
var horPos: int
var verPos: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not ships.preStage:
			if ships.turn == 0:
				if ships.p1ShotArray[verPos][horPos] == 0:
					peg.position = self.global_position
					peg.horPos = horPos
					peg.verPos = verPos
			else:
				if ships.p2ShotArray[verPos][horPos] == 0:
					peg.position = self.global_position
					peg.horPos = horPos
					peg.verPos = verPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
