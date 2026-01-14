extends Area2D

var id: int
@onready var Scroller = get_node("../../../Campaign") 
@onready var Controller = get_node("../../Control")
@onready var PlayBoard = get_node("../../../PlayBoard")
@onready var LevelInfo = get_node("../../../LevelInfo")
var direc
var locked
var file 
var json 
var title 
var diff 
var desc
var sprite: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direc = "res://storyModeNonograms/" + Controller.stories[id]
	file = FileAccess.open(direc, FileAccess.READ)
	json = JSON.parse_string(file.get_as_text())
	title = json["info"][0]["title"]
	diff = json["info"][1]["diff"]
	diff = int(diff)
	desc = json["info"][2]["desc"]
	locked = json["info"][3]["locked"]
	input_event.connect(_on_input_event)
	#if diff:
		#diff = 0
	#if desc:
		#desc = "Error in obtaining information"
	#if title:
		#title = "Error!"
	pass # Replace with function body.

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not sprite.texture == load("res://images/nodelocked.png"):
		get_node("../../../Import and Export").hide()
		print("woah")
		print("res://storyModeNonograms/" + Controller.stories[id])
		Controller.currentStory = Controller.stories[id]
		Controller.inGame = true
		PlayBoard.openAndGenerate("res://storyModeNonograms/" + Controller.stories[id])
		PlayBoard.show()
		Scroller.hide()
		LevelInfo.hide()
		get_node("../../../Back").show()
	else:
		LevelInfo.show()
		var infoSprite = LevelInfo.get_node("InfoSprite")
		LevelInfo.position = self.global_position + Vector2(50,0)
		LevelInfo.get_node("Title").set_text(title)
		LevelInfo.get_node("Description").set_text(desc)
		LevelInfo.get_node("Difficulty").set_text(str(diff))
		if diff >= 0 and diff < 4:
			infoSprite.texture = load("res://images/information/infoEasy.png")
		if diff > 3 and diff < 7:
			infoSprite.texture = load("res://images/information/infoMedium.png")
		if diff > 6 and diff < 11:
			infoSprite.texture = load("res://images/information/infoHard.png")
		if diff > 10 and diff < 14:
			infoSprite.texture = load("res://images/information/infoInsane.png")
		if diff == 14:
			infoSprite.texture = load("res://images/information/infoCrazy.png")
		if diff >= 15:
			infoSprite.texture = load("res://images/information/infoExpert.png")
			
		if diff > 6:
			LevelInfo.get_node("Difficulty").add_theme_color_override("font_color", "#dec371")
		else:
			LevelInfo.get_node("Difficulty").set("theme_override_colors/font_color", Color.BLACK)
		
		
func update():
	if Controller.stories[id] in Controller.completedStories:
		sprite.texture = load("res://images/nodecomplete.png")
		Controller.data.set_value("Progress","Complete",Controller.completedStories)
		Controller.data.save(Controller.story_data)
	else:
		if locked > -1 and locked > len(Controller.completedStories):
			sprite.texture = load("res://images/nodelocked.png")
		else:
			sprite.texture = load("res://images/node.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
