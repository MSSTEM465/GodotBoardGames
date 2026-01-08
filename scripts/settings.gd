extends Area2D

@onready var af = get_tree().root.get_node("Node2D/SettingsPage/Autofill Button")
@onready var playBoard = get_tree().root.get_node("Node2D/PlayBoard")
@onready var penalize = get_tree().root.get_node("Node2D/SettingsPage/Penalize Button")
@onready var correction = get_tree().root.get_node("Node2D/SettingsPage/Correction Button")
@onready var empty = load("res://images/empty.png")
@onready var marked = load("res://images/marked.png")
@onready var settingsIcon = get_tree().root.get_node("Node2D/Settings Icon")
@onready var exit = get_tree().root.get_node("Node2D/SettingsPage/Exit")
@onready var entireSettings = get_tree().root.get_node("Node2D/SettingsPage")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self == exit:
			entireSettings.hide()
		if self == settingsIcon:
			entireSettings.show()
		if self == af:
			var sprite = get_node("Sprite2D")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.autofill = true
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.autofill = false
		if self == correction:
			var sprite = get_node("Sprite2D")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.correction = true
				penalize.show()
				
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.correction = false
				penalize.hide()
		if self == penalize:
			var sprite = get_node("Sprite2D")
			if sprite.texture == empty:
				sprite.texture = marked
				playBoard.penalize = true
			elif sprite.texture == marked:
				sprite.texture = empty
				playBoard.penalize = false
		
	pass # Replace with function body.
