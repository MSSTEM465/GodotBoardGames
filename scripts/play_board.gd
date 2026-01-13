extends Node2D

var arraySolution: Array
var arraySelected: Array
var labels = []
var lives = 5
var horLeng: int # horizontal length (left & right)
var verLeng: int # vertical length (up & down)
var completed = false
@onready var fileOpener = get_node("../OpenFile")

var autofill = false
var correction = false
var penalize = false

func _input(event) -> void:
	self.position = Vector2(self.position.x + (Input.get_axis("moveleft","moveright") * 10),self.position.y + (Input.get_axis("moveup","movedown") * 10))
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func niceOneIdiot(): # Code ran by grid to remove itself when failed. Name is necessary
	labels = []
	for n in get_children():
		n.queue_free()

func openAndGenerate(path):
	for n in get_children():
		n.queue_free()
	completed = false
	get_node("../Warnings").set_text("")
	var json
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		json = JSON.parse_string(file.get_as_text())
		horLeng = json["boardData"][0]["boardW"]
		verLeng = json["boardData"][1]["boardH"]
		arraySolution = json["boardArray"]
		for e in range(len(arraySolution)):
			for f in range(len(arraySolution[e])):
				arraySolution[e][f] = int(arraySolution[e][f])
	else:
		print("Error in opening file")
		return
	labels = []
	arraySelected = []
	for i in range(verLeng):
		arraySelected.append([])
		arraySelected[i] = []
		for o in range(horLeng):
			arraySelected[i].append([])
			arraySelected[i][o] = 0
			var area := Area2D.new()
			area.set_script(load("res://scripts/forGridPlay.gd"))
			add_child(area)

			var sprite := Sprite2D.new()
			if arraySolution[i][o] == 2:
				sprite.texture = load("res://images/marked.png")
				arraySelected[i][o] = 2
			else:
				sprite.texture = load("res://images/empty.png")
			sprite.position = Vector2(o * 50, i * 50)
			area.add_child(sprite)
			
			area.sprite = sprite
			area.hori = o
			area.vert = i
			var collision := CollisionShape2D.new()
			var shape := RectangleShape2D.new()
			var hintHori := Label.new()
			var hintVert := Label.new()
			if i == 0:
				hintHori = Label.new()
				hintHori.set_script(load("res://scripts/forLabelPlay.gd"))
				hintHori.set_text("0")
				hintHori.add_theme_color_override("font_color", Color(0, 0, 0))
				hintHori.add_theme_font_size_override("font_size", 30)
				hintHori.global_position = Vector2(sprite.position.x,sprite.position.y-30)
				hintHori.location = o
				hintHori.grow_horizontal = 0
				hintHori.grow_vertical = 0
				labels.append(hintHori)
				hintHori.ifVert = false
				area.add_child(hintHori)
			if o == 0:
				hintVert = Label.new()
				hintVert.set_script(load("res://scripts/forLabelPlay.gd"))
				hintVert.set_text("0")
				hintVert.add_theme_color_override("font_color", Color(0, 0, 0))
				hintVert.add_theme_font_size_override("font_size", 30)
				hintVert.grow_vertical = 0
				hintVert.grow_horizontal = 0
				hintVert.global_position = Vector2(sprite.position.x-40,sprite.position.y)
				hintVert.location = i
				hintVert.ifVert = true
				labels.append(hintVert)
				area.add_child(hintVert)
			shape.size = Vector2(50, 50)
			collision.shape = shape
			collision.position = sprite.position
			area.add_child(collision)
	for l in labels:
		l.update()
	var finalPosition = Vector2(get_viewport().size.x/2,get_viewport().size.y/2) - Vector2((horLeng*50/2),(verLeng*50/2))
	self.position = finalPosition
	print(arraySolution)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
