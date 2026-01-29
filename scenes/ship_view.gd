extends Node2D

var p1ShipArray: Array
var p2ShipArray: Array
var p1NamingArray: Array
var p2NamingArray: Array
var p1ShotArray: Array
var p2ShotArray: Array
var preStage := true
var turn = 0
var list = ["A","B","C",'D','E',"F",'G','H','I',"J","K"]
var carrier = preload("res://images/battleship/carrier.png")
var bs = preload("res://images/battleship/battleship.png")
var sm = preload("res://images/battleship/submarine.png")
var dt = preload("res://images/battleship/destroyer.png")
var cs = preload("res://images/battleship/cruiser.png")
var endGame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()
	pass # Replace with function body.

func checkWon():
	#print("Checking win condition")
	#print(Time.get_unix_time_from_system())
	if turn == 0:
		for i in range(len(p1ShipArray)):
			for j in range(len(p1ShipArray[i])):
				if p1ShipArray[i][j] > 0 and p2ShotArray[i][j] == 0:
					#print("Last move did not win game")
					#print(Time.get_unix_time_from_system())
					return false
	else:
		for i in range(len(p2ShipArray)):
			for j in range(len(p2ShipArray[i])):
				if p2ShipArray[i][j] > 0 and p1ShotArray[i][j] == 0:
					#print("Last move did not win game")
					#print(Time.get_unix_time_from_system())
					return false
	print("Won!")
	print(Time.get_unix_time_from_system())
	return true

func updateArrayRewrite():
	if turn == 0:
		for i in range(len(p1ShipArray)):
			for g in range(len(p1ShipArray[i])):
				p1ShipArray[i][g] = 0
	else:
		for i in range(len(p2ShipArray)):
			for g in range(len(p2ShipArray[i])):
				p2ShipArray[i][g] = 0
	var direction: Array
	for i in get_children():
		for g in i.get_children():
			if g is Sprite2D:
				if not g.texture == load("res://images/battleship/tile.png"):
					if g.texture == cs:
						direction = [0,1]
					if g.texture == dt:
						direction = [0,-1,1]
					if g.texture == bs:
						direction = [-1,0,1,2]
					if g.texture == sm:
						direction = [1,0,-1]
					if g.texture == carrier:
						direction = [-2,-1,0,1,2]
					for f in direction:
						if g.rotation_degrees == 90:
							if turn == 0:
								p1NamingArray[i.vertPos][i.horiPos] = g.texture
								p1ShipArray[i.vertPos][i.horiPos] = 3
								p1ShipArray[i.vertPos+f][i.horiPos] = 1
							else:
								p2NamingArray[i.vertPos][i.horiPos] = g.texture
								p2ShipArray[i.vertPos][i.horiPos] = 3
								p2ShipArray[i.vertPos+f][i.horiPos] = 1
						else:
							if turn == 0:
								p1NamingArray[i.vertPos][i.horiPos] = g.texture
								p1ShipArray[i.vertPos][i.horiPos] = 2
								p1ShipArray[i.vertPos][i.horiPos+f] = 1
							else:
								p2NamingArray[i.vertPos][i.horiPos] = g.texture
								p2ShipArray[i.vertPos][i.horiPos] = 2
								p2ShipArray[i.vertPos][i.horiPos+f] = 1
					
func checkValidity(origin,ship,vertical):
	updateArrayRewrite()
	var direction
	if ship == "Cruiser":
		direction = [0,1]
	elif ship == "Destroyer":
		direction = [0,-1,1]
	elif ship == "Battleship":
		direction = [0,-1,1,2]
	elif ship == "Submarine":
		direction = [0,-1,1]
	elif ship == "Carrier":
		direction = [-1,-2,0,1,2]
	for i in direction:
		if vertical:
			if (origin[0] + i < 10 and origin[0] + i > -1):
				pass
			else:
				print(origin[0])
				print(origin[1])
				return false
		else:
			if (origin[1] + i < 10 and origin[1] + i > -1):
				pass
			else:
				return false
		if vertical:
			if turn == 0:
				if p1ShipArray[origin[0]+i][origin[1]] != 0:
					return false
			else:
				if p2ShipArray[origin[0]+i][origin[1]] != 0:
					return false
		else:
			if turn == 0:
				if p1ShipArray[origin[0]][origin[1]+i] != 0:
					return false
			else:
				if p2ShipArray[origin[0]][origin[1]+i] != 0:
					return false
	return true

func initialize():
	p1ShipArray = []
	p2ShipArray = []
	p1NamingArray = []
	p2NamingArray = []
	p1ShotArray = []
	p2ShotArray = []
	for i in range(10):
		p1ShipArray.append([])
		p2ShipArray.append([])
		p1NamingArray.append([])
		p2NamingArray.append([])
		p1ShotArray.append([])
		p2ShotArray.append([])
		for j in range(10):
			p1ShipArray[i].append(0)
			p2ShipArray[i].append(0)
			p1NamingArray[i].append(0)
			p2NamingArray[i].append(0)
			p1ShotArray[i].append(0)
			p2ShotArray[i].append(0)
	generate()
	get_node("../Map").generate()

func generate():
	for i in get_children():
		i.queue_free()
	for i in range(10):
		for j in range(10):
			var area = Area2D.new()
			var col = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			var sprite = Sprite2D.new()
			shape.size = Vector2(50,50)
			col.shape = shape
			sprite.texture = load("res://images/battleship/tile.png")
			area.add_child(col)
			area.add_child(sprite)
			area.set_script(load("res://scripts/bsTiles.gd"))
			area.horiPos = j
			area.vertPos = i
			area.position = Vector2(j*50,i*50)
			self.add_child(area)
			if i == 0:
				var label = Label.new()
				label.set_text(list[j])
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(j-10,-70)
				area.add_child(label)
			if j == 0:
				var label = Label.new()
				label.set_text(str(i+1))
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(-40,i-25)
				label.grow_horizontal = 0
				area.add_child(label)
	pass

func generateWithInfo():
	for i in get_children():
		i.queue_free()
	for i in range(10):
		for j in range(10):
			var area = Area2D.new()
			var col = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			var sprite = Sprite2D.new()
			var ship = Sprite2D.new()
			if turn == 0:
				if p1ShipArray[i][j] == 2:
					ship.texture = p1NamingArray[i][j]
					ship.rotation_degrees = 0
					area.add_child(ship)
				if p1ShipArray[i][j] == 3:
					ship.texture = p1NamingArray[i][j]
					ship.rotation_degrees = 90
					area.add_child(ship)
			else:
				if p2ShipArray[i][j] == 2:
					ship.texture = p2NamingArray[i][j]
					ship.rotation_degrees = 0
					area.add_child(ship)
				if p2ShipArray[i][j] == 3:
					ship.texture = p2NamingArray[i][j]
					ship.rotation_degrees = 90
					area.add_child(ship)
			ship.z_index = 30
			shape.size = Vector2(50,50)
			col.shape = shape
			sprite.texture = load("res://images/battleship/tile.png")
			area.add_child(col)
			area.add_child(sprite)
			#area.set_script(load("res://scripts/bsTiles.gd"))
			#area.horiPos = j
			#area.vertPos = i
			area.position = Vector2(j*50,i*50)
			if turn == 0:
				if p2ShotArray[i][j] == 1:
					var peg = Sprite2D.new()
					peg.texture = load("res://images/battleship/whitePeg.png")
					peg.z_index = 40
					area.add_child(peg)
				elif p2ShotArray[i][j] == 2:
					var peg = Sprite2D.new()
					peg.z_index = 40
					peg.texture = load("res://images/battleship/redPeg.png")
					area.add_child(peg)
			else:
				if p1ShotArray[i][j] == 1:
					var peg = Sprite2D.new()
					peg.z_index = 40
					peg.texture = load("res://images/battleship/whitePeg.png")
					area.add_child(peg)
				elif p1ShotArray[i][j] == 2:
					var peg = Sprite2D.new()
					peg.z_index = 40
					peg.texture = load("res://images/battleship/redPeg.png")
					area.add_child(peg)
			self.add_child(area)
			if i == 0:
				var label = Label.new()
				label.set_text(list[j])
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(j-10,-70)
				area.add_child(label)
			if j == 0:
				var label = Label.new()
				label.set_text(str(i+1))
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(-40,i-25)
				label.grow_horizontal = 0
				area.add_child(label)
	pass

func shipCheckSunk(verPos,horPos,player):
	var direc := []
	var rightShip = false
	var failure = true
	if player == 0:
		for i in range(len(p1ShipArray)):
			for j in range(len(p1ShipArray[i])):
				rightShip = false
				if p1ShipArray[i][j] > 1:
					if p1NamingArray[i][j] == cs:
						direc = [0,1]
					elif p1NamingArray[i][j] == dt:
						direc = [0,-1,1]
					elif p1NamingArray[i][j] == bs:
						direc = [0,-1,1,2]
					elif p1NamingArray[i][j] == sm:
						direc = [0,-1,1]
					elif p1NamingArray[i][j] == carrier:
						direc = [-1,-2,0,1,2]
					for g in direc:
						if p1ShipArray[i][j] == 2:
							if verPos == i and horPos == j+g:
								rightShip = true
						if p1ShipArray[i][j] == 3:
							if verPos == i+g and horPos == j:
								rightShip = true
					if rightShip:
						failure = false
						for g in direc:
							if p1ShipArray[i][j] == 2:
								if p2ShotArray[i][j+g] == 0:
									failure = true
									#print("Failure???")
							if p1ShipArray[i][j] == 3:
								if p2ShotArray[i+g][j] == 0:
									failure = true
									#print("Failure???")
					if not failure:
						return true
	elif player == 1:
		for i in range(len(p2ShipArray)):
			for j in range(len(p2ShipArray[i])):
				rightShip = false
				if p2ShipArray[i][j] > 1:
					if p2NamingArray[i][j] == cs:
						direc = [0,1]
					elif p2NamingArray[i][j] == dt:
						direc = [0,-1,1]
					elif p2NamingArray[i][j] == bs:
						direc = [0,-1,1,2]
					elif p2NamingArray[i][j] == sm:
						direc = [0,-1,1]
					elif p2NamingArray[i][j] == carrier:
						direc = [-1,-2,0,1,2]
					for g in direc:
						if p2ShipArray[i][j] == 2:
							if verPos == i and horPos == j+g:
								rightShip = true
						if p2ShipArray[i][j] == 3:
							if verPos == i+g and horPos == j:
								rightShip = true
					if rightShip:
						failure = false
						for g in direc:
							if p2ShipArray[i][j] == 2:
								if p1ShotArray[i][j+g] == 0:
									failure = true
									#print("Failure???")
							if p2ShipArray[i][j] == 3:
								if p1ShotArray[i+g][j] == 0:
									failure = true
									#print("Failure???")
					else:
						failure = true
					if not failure:
						print(direc)
						print(i,j)
						return true
	return false

func showP1():
	print("Started generating Player 1 Map")
	print(Time.get_unix_time_from_system())
	for i in get_children():
		i.queue_free()
	for i in range(10):
		for j in range(10):
			var area = Area2D.new()
			var col = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			var sprite = Sprite2D.new()
			var ship = Sprite2D.new()
			if p1ShipArray[i][j] == 2:
				ship.texture = p1NamingArray[i][j]
				ship.rotation_degrees = 0
				area.add_child(ship)
			if p1ShipArray[i][j] == 3:
				ship.texture = p1NamingArray[i][j]
				ship.rotation_degrees = 90
				area.add_child(ship)
			ship.z_index = 30
			shape.size = Vector2(50,50)
			col.shape = shape
			sprite.texture = load("res://images/battleship/tile.png")
			area.add_child(col)
			area.add_child(sprite)
			#area.set_script(load("res://scripts/bsTiles.gd"))
			#area.horiPos = j
			#area.vertPos = i
			area.position = Vector2(j*50,i*50)
			if p2ShotArray[i][j] == 1:
				var peg = Sprite2D.new()
				peg.texture = load("res://images/battleship/whitePeg.png")
				peg.z_index = 40
				area.add_child(peg)
			elif p2ShotArray[i][j] == 2:
				var peg = Sprite2D.new()
				peg.z_index = 40
				peg.texture = load("res://images/battleship/redPeg.png")
				area.add_child(peg)
			self.add_child(area)
			if i == 0:
				var label = Label.new()
				label.set_text(list[j])
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(j-10,-70)
				area.add_child(label)
			if j == 0:
				var label = Label.new()
				label.set_text(str(i+1))
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(-40,i-25)
				label.grow_horizontal = 0
				area.add_child(label)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
