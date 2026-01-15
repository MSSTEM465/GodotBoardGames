extends Node2D

var array: Array
var cellArray: Array
var black = preload("res://images/black.png")
var empty = preload("res://images/none.png")
var white = preload("res://images/white.png")
var turn = 2
var moves = 0
var numOfBlack := 0
var numOfWhite := 0

# 0: None
# 1: White
# 2: Black

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateBoard()
	pass # Replace with function body.

func generateBoard():
	for n in get_children():
		n.queue_free()
	
	for i in range(8):
		array.append([])
		cellArray.append([])
		for h in range(8):
			if (h == 3 and i == 3) or (h == 4 and i == 4):
				array[i].append(1)
			elif (h == 3 and i == 4) or (h == 4 and i == 3):
				array[i].append(2)
			else:
				array[i].append(0)
			
			var area = Area2D.new()
			cellArray[i].append(area)
			var coll = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			var sprite = Sprite2D.new()
			if array[i][h] == 1:
				sprite.texture = white
			elif array[i][h] == 2:
				sprite.texture = black
			elif array[i][h] == 0:
				sprite.texture = empty
			shape.size = Vector2(50,50)
			coll.shape = shape
			area.add_child(coll)
			area.add_child(sprite)
			area.set_script(load("res://scripts/cell.gd"))
			area.horiPos = h
			area.vertPos = i
			area.selfSprite = sprite
			area.position = Vector2(h*50,i*50)
			self.add_child(area)
			self.position = Vector2(1920/2-50*4+25,1080/2-50*4+25)
			
	print(array)
	for i in get_children():
		i.checkValidMovement()
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
