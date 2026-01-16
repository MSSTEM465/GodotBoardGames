extends Node2D
var array: Array
var areaArray: Array
var siz: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateBoard([20,20])
	pass # Replace with function body.

func _input(event) -> void:
	self.position = Vector2(self.position.x + (Input.get_axis("moveleft","moveright") * 10),self.position.y + (Input.get_axis("moveup","movedown") * 10))


# size = [vertical length, horizontal length]
func generateBoard(size):
	siz = size
	for i in range(size[0]):
		array.append([])
		areaArray.append([])
		for h in range(size[1]):
			array[i].append(0)
			
			var area = Area2D.new()
			var coll = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			var sprite = Sprite2D.new()
			shape.size = Vector2(50,50)
			coll.shape = shape
			area.add_child(coll)
			area.add_child(sprite)
			sprite.texture = load("res://images/minesweeper/click.png") 
			area.position = Vector2(h*50,i*50)
			area.set_script(load("res://scripts/mines.gd"))
			area.horiPos = h
			area.vertPos = i
			area.sprite = sprite
			areaArray[i].append(area)
			self.add_child(area)
	var count = 0
	while count < 50:
		var rand1 = randi() % size[0]
		var rand2 = randi() % size[1]
		if array[rand1][rand2] == 1:
			pass
		else:
			array[rand1][rand2] = 1
			count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
