extends Area2D

var id: int
@onready var Scroller = get_node("../../../Campaign") 
@onready var Controller = get_node("../../Control")
@onready var PlayBoard = get_node("../../../PlayBoard")
var sprite: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("woah")
		print("res://storyModeNonograms/" + Controller.stories[id])
		Controller.currentStory = Controller.stories[id]
		Controller.inGame = true
		PlayBoard.openAndGenerate("res://storyModeNonograms/" + Controller.stories[id])
		PlayBoard.show()
		Scroller.hide()
	else:
		print("huh")
		
func update():
	if Controller.stories[id] in Controller.completedStories:
		sprite.texture = load("res://images/nodecomplete.png")
		Controller.data.set_value("Progress","Complete",Controller.completedStories)
		Controller.data.save(Controller.story_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
