extends Node2D
var array: Array
var areaArray: Array
var siz: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#generateBoard([20,20],50)
	pass # Replace with function body.

func _input(event) -> void:
	self.position = Vector2(self.position.x + (Input.get_axis("moveleft","moveright") * 10),self.position.y + (Input.get_axis("moveup","movedown") * 10))

# Easy: [9,9], 10
# Medium: [16,16], 40
# Hard: [16,30], 99

# size = [vertical length, horizontal length]
func generateBoard(size, mines):
	get_node("../Stopwatch").start()
	array = []
	areaArray = []
	for i in get_children():
		i.queue_free()
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
	while count < mines:
		var rand1 = randi() % size[0]
		var rand2 = randi() % size[1]
		if array[rand1][rand2] == 1:
			pass
		else:
			array[rand1][rand2] = 1
			count += 1

	var nope = false
	var dontContinue = false
	var list = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
	for x in range(len(array)):
		for h in range(len(array)):
			nope = false
			if array[x][h] == 0:
				for i in range(8):
					if (x + list[i][0] <= siz[0]-1 and h + list[i][1] <= siz[1]-1) and (x + list[i][0] >= 0 and h + list[i][1] >= 0):
						if array[x + list[i][0]][h + list[i][1]] == 1:
							#print("hauh")
							nope = true
			else:
				nope = true
			if not nope and not dontContinue:
				#print("niodsvosnifd")
				areaArray[x][h].sprite.texture = load("res://images/minesweeper/x.png")
				nope = true
				dontContinue = true
				break
	get_node("../FlagCount").recount()
	self.position = Vector2(1920/2-(50*size[1])/2,1080/2-(50*size[0])/2)
	#while not sigh:
		#var rand1 = randi() % size[0]
		#var rand2 = randi() % size[1]
		#var list = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
		#for i in range(8):
			#if (rand1 + list[i][0] <= siz[0]-1 and rand2 + list[i][1] <= siz[1]-1) and (rand1 + list[i][0] >= 0 and rand2 + list[i][1] >= 0):
				#if array[rand1 + list[i][0]][rand2 + list[i][1]] == 1:
					#nope = true
		#if not nope:
			#areaArray[rand1][rand2].sprite.texture = load("res://images/minesweeper/x.png")
			#sigh = true

func failure():
	get_node("../Stopwatch").started = false
	for i in range(len(array)):
		for j in range(len(array[i])):
			if array[i][j] == 1:
				areaArray[i][j].reveal()
			areaArray[i][j].revealed = true
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
