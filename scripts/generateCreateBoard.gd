extends Node

var array=[]
var aTerribleIdeaX = []
var aTerribleIdeaY = []
var curSizeX: int
var curSizeY: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _input(event) -> void:
	#print(event)
	if event is InputEventKey and event.as_text_key_label() == "G":
		var sizex = get_node("../CBFX").value
		var sizey = get_node("../CBFY").value
		createBoard([sizex,sizey])
	elif event is InputEventKey:
		var speed = 5
		if event.as_text_key_label() == "Up":
			self.position = Vector2(self.position.x,self.position.y-speed)
		if event.as_text_key_label() == "Down":
			self.position = Vector2(self.position.x,self.position.y+speed)
		if event.as_text_key_label() == "Left":
			self.position = Vector2(self.position.x-speed,self.position.y)
		if event.as_text_key_label() == "Right":
			self.position = Vector2(self.position.x+speed,self.position.y)
		if event.as_text_key_label() == "E" and not curSizeX == null:
			var json = JSON.new()
			var file = FileAccess.open("user://nonogram.json", FileAccess.WRITE)
			var createBoardJson = {
				"boardData": [
					{"boardW": curSizeY},
					{"boardH": curSizeX}
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
			print(createBoardJson)
		
func createBoard(size):
	for n in get_children():
		n.queue_free()
	array = []
	curSizeX = size[0]
	curSizeY = size[1]
	aTerribleIdeaX = []
	aTerribleIdeaY = []
	for i in range(size[0]):
		
		array.append([])
		array[i] = []
		for o in range(size[1]):
			array[i].append([])
			array[i][o] = 0
			var area := Area2D.new()
			area.set_script(load("res://scripts/forGrid.gd"))
			add_child(area)

			var sprite := Sprite2D.new()
			sprite.texture = load("res://images/empty.png")
			sprite.position = Vector2(i * 50, o * 50)
			area.add_child(sprite)
			
			area.sprite = sprite
			area.x = o
			area.y = i
			var collision := CollisionShape2D.new()
			var shape := RectangleShape2D.new()
			var hintX := Label.new()
			var hintY := Label.new()
			if i == 0:
				hintX = Label.new()
				hintX.set_script(load("res://scripts/forLabels.gd"))
				hintX.set_text("0")
				hintX.add_theme_color_override("font_color", Color(0, 0, 0))
				hintX.add_theme_font_size_override("font_size", 30)
				print(hintX, hintX.get_text())
				hintX.global_position = Vector2(sprite.position.x-50,sprite.position.y-20)
				hintX.location = o
				hintX.grow_horizontal = 0
				print(hintX)
				print(hintX.location,i)
				aTerribleIdeaX.append(hintX)
				hintX.ifX = true
				area.add_child(hintX)
			if o == 0:
				hintY = Label.new()
				hintY.set_script(load("res://scripts/forLabels.gd"))
				hintY.set_text("0")
				hintY.add_theme_color_override("font_color", Color(0, 0, 0))
				hintY.add_theme_font_size_override("font_size", 30)
				hintY.grow_vertical = 0
				hintY.global_position = Vector2(sprite.position.x-10,sprite.position.y-60)
				hintY.location = i
				aTerribleIdeaY.append(hintY)
				area.add_child(hintY)
			shape.size = Vector2(50, 50)
			collision.shape = shape
			collision.position = sprite.position
			area.add_child(collision)
	#print(array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
