extends Area2D

@onready var nonogram = get_node("../Nonogram")
@onready var Reversi = get_node("../Reversi")
@onready var Minesweeper = get_node("../Minesweeper")
@onready var knuckle = get_node("../Knucklebones")
@onready var battleship = get_node("../Battleship")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self == nonogram:
			Loadingmanager.load_scene("res://scenes/gameplay.tscn")
		if self == Reversi:
			Loadingmanager.load_scene("res://scenes/reversi.tscn")
		if self == Minesweeper:
			Loadingmanager.load_scene("res://scenes/minesweeper.tscn")
		if self == knuckle:
			Loadingmanager.load_scene("res://scenes/knucklebones.tscn")
		if self == battleship:
			Loadingmanager.load_scene("res://scenes/battleship.tscn")
	pass # Replace with function body.
