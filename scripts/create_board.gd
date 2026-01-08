extends Node2D

var array: Array
var labels = []
var horLeng: int # horizontal length (left & right)
var verLeng: int # vertical length (up & down)
@onready var fileSaver = get_node("../SaveFile")

# IMPORTANT FOR ORGANIZATION
# size = [horizontal length, vertical length]
# size = [2,3]
# [0],[0]
# [0],[0]
# [0],[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#generate([3,6])
	pass # Replace with function body.

func saveFile(path):
	var json
	var file = FileAccess.open(path, FileAccess.WRITE)
	var createBoardJson = {
		"boardData": [
			{"boardW": horLeng},
			{"boardH": verLeng}
		],
		"boardArray": array
		}
	if file:
		json = JSON.stringify(createBoardJson)
		file.store_string(json)
		file.close()
		print("Sucessfully saved")
	else:
		print("Failure to save")
	#print(createBoardJson)
	

func _input(event) -> void:
	self.position = Vector2(self.position.x + (Input.get_axis("moveleft","moveright") * 10),self.position.y + (Input.get_axis("moveup","movedown") * 10))
	if event.is_action_pressed("export"):
		fileSaver.visible = true
		

func generate(size):
	var verLeng = size[1]
	var horLeng = size[0]
	labels = []
	for n in get_children():
		n.queue_free()
	array = []
	
	for i in range(verLeng):
		array.append([])
		array[i] = []
		for o in range(horLeng):
			array[i].append([])
			array[i][o] = 0
			var area := Area2D.new()
			area.set_script(load("res://scripts/forGridCreate.gd"))
			add_child(area)

			var sprite := Sprite2D.new()
			sprite.texture = load("res://images/empty.png")
			sprite.position = Vector2(o * 50, i * 50)
			area.add_child(sprite)
			area.sprite = sprite
			area.hori = o
			area.vert = i
			var collision := CollisionShape2D.new()
			var shape := RectangleShape2D.new()
			shape.size = Vector2(50, 50)
			collision.shape = shape
			collision.position = sprite.position
			area.add_child(collision)
			var hintVert := Label.new()
			var hintHori := Label.new()
			if i == 0:
				hintVert = Label.new()
				hintVert.set_script(load("res://scripts/forLabelCreate.gd"))
				hintVert.set_text("0")
				hintVert.add_theme_color_override("font_color", Color(0, 0, 0))
				hintVert.add_theme_font_size_override("font_size", 30)
				hintVert.global_position = Vector2(sprite.position.x-10,sprite.position.y-35)
				hintVert.location = o
				hintVert.grow_vertical = 0
				hintVert.ifVert = false
				labels.append(hintVert)
				area.add_child(hintVert)
			if o == 0:
				hintHori = Label.new()
				hintHori.set_script(load("res://scripts/forLabelCreate.gd"))
				hintHori.set_text("0")
				hintHori.add_theme_color_override("font_color", Color(0, 0, 0))
				hintHori.add_theme_font_size_override("font_size", 30)
				hintHori.global_position = Vector2(sprite.position.x-45,sprite.position.y-20)
				hintHori.location = i
				hintHori.grow_horizontal = 0
				hintHori.ifVert = true
				labels.append(hintHori)
				area.add_child(hintHori)
			area.labels = labels
	
	var finalPosition = Vector2(get_viewport().size.x/2,get_viewport().size.y/2) - Vector2((horLeng*50/2),(verLeng*50/2))
	self.position = finalPosition



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
