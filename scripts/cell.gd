extends Area2D # REVERSI
var dirs: Array
var betterDirs: Array
var direcs = [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]]
var empty = preload("res://images/none.png")
var grey = preload("res://images/grey.png")
var black = preload("res://images/black.png")
var white = preload("res://images/white.png")
@onready var selfSprite: Sprite2D
@onready var horiPos: int
@onready var vertPos: int
@onready var board = get_node("../../board")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if selfSprite.texture == grey:
				betterFlip()
				if board.turn == 1:
					board.turn = 2
					get_node("../../Turn").texture = black
				elif board.turn == 2:
					board.turn = 1
					get_node("../../Turn").texture = white
				board.moves = 0
				for i in board.get_children():
					i.checkBetterMovement()
				if board.moves == 0:
					print("No moves detected. Skipping turn")
					if board.turn == 2:
						board.turn = 1
						get_node("../../Turn").texture = white
					else:
						board.turn = 2
						get_node("../../Turn").texture = black
					for i in board.get_children():
						i.checkBetterMovement()
					if board.moves == 0:
						print("Game over")
						for i in board.get_children():
							if i.selfSprite.texture == black:
								board.numOfBlack += 1
							if i.selfSprite.texture == white:
								board.numOfWhite += 1
						if board.numOfWhite > board.numOfBlack:
							get_node("../../whiteWin").emitting = true
						if board.numOfWhite < board.numOfBlack:
							get_node("../../blackWin").emitting = true
						if board.numOfWhite == board.numOfBlack:
							get_node("../../blackWin").emitting = true
							get_node("../../whiteWin").emitting = true

func update():
	if board.array[vertPos][horiPos] == 0:
		selfSprite.texture = empty
	if board.array[vertPos][horiPos] == 1:
		selfSprite.texture = white
	if board.array[vertPos][horiPos] == 2:
		selfSprite.texture = black

# Atleast I thought of optimization using the dir directory. Subject for deletion
func flippenTime():
	var tempHori = 0
	var tempVert = 0
	var flipNum = 0
	var direction = dirs[flipNum] # 0 is up, goes in clockwise movement 45 degrees every integer increasement
	var prevention = false
	var death = true
	if selfSprite.texture == load("res://images/black.png") or selfSprite.texture == load("res://images/white.png"):
		death = false
	while death:
		if (tempHori + horiPos > 7) or (tempVert + vertPos > 7) or (horiPos + tempHori < 0) or (vertPos + tempVert < 0):
			print("WTF")
			tempHori = 0
			tempVert = 0
			flipNum += 1
			if flipNum + 1 > len(dirs):
				death = false
			else:
				direction = dirs[flipNum]
			if direction == 8:
				death = false
		if (board.array[vertPos + tempVert][horiPos + tempHori] == board.turn) and not (tempHori == 0 and tempVert == 0):
			if (tempHori > 1 or tempHori < -1) or (tempVert > 1 or tempVert < -1):
				#print(horiPos,tempHori,vertPos,tempVert)
				#print(direction)
				#print(board.array[horiPos + tempHori][vertPos + tempVert])
				#print("ayy")
				#selfSprite.texture = load("res://images/grey.png")
				tempHori = 0
				tempVert = 0
				if flipNum + 2 > len(dirs):
					death = false
				else:
					flipNum += 1
					direction = dirs[flipNum]
					
				prevention = true
			else:
				tempHori = 0
				tempVert = 0
				if flipNum + 1 > len(dirs):
					death = false
				else:
					direction = dirs[flipNum]
				prevention = true
		board.array[vertPos + tempVert][horiPos + tempHori] = board.turn
		if not prevention:
			if direction == 0:
				tempVert -= 1
				tempHori = 0
			if direction == 1:
				tempHori += 1
				tempVert -= 1
			if direction == 2:
				tempHori += 1
				tempVert = 0
			if direction == 3:
				tempHori += 1
				tempVert += 1
			if direction == 4:
				tempVert += 1
				tempHori = 0
			if direction == 5:
				tempVert += 1
				tempHori -= 1
			if direction == 6:
				tempHori -= 1
				tempVert = 0
			if direction == 7:
				tempHori -= 1
				tempVert -= 1
		if direction == 8:
			death = false
		prevention = false
	update()
	for i in board.get_children():
		i.update()

func betterFlip():
	var multiplier = 1
	if selfSprite.texture == load("res://images/black.png") or selfSprite.texture == load("res://images/white.png"):
		return
	#print(betterDirs)
	for i in betterDirs:
		multiplier = 1
		board.array[vertPos][horiPos] = board.turn
		while (board.array[vertPos + (i[1]*multiplier)][horiPos + (i[0]*multiplier)] == opposite(board.turn)):
			board.array[vertPos + (i[1]*multiplier)][horiPos + (i[0]*multiplier)] = board.turn
			multiplier += 1
	for i in board.get_children():
		i.update()

func opposite(data):
	if data == 1:
		return 2
	elif data == 2:
		return 1
	else:
		return 0

func checkBetterMovement():
	var multiplier = 1
	betterDirs = []
	if selfSprite.texture == load("res://images/black.png") or selfSprite.texture == load("res://images/white.png"):
		return
	for i in direcs:
		if ((i[0]) + horiPos > 7) or ((i[1]) + vertPos > 7) or (horiPos + (i[0]) < 0) or (vertPos + (i[1]) < 0):
			continue
		if (board.array[vertPos + i[1]][horiPos + i[0]] == opposite(board.turn)):
			multiplier = 1
			#board.moves += 1
			while (board.array[vertPos + (i[1]*multiplier)][horiPos + (i[0]*multiplier)] == opposite(board.turn)):
				multiplier += 1
				if ((i[0]*multiplier) + horiPos > 7) or ((i[1]*multiplier) + vertPos > 7) or (horiPos + (i[0]*multiplier) < 0) or (vertPos + (i[1]*multiplier) < 0):
					break
				if (board.array[vertPos + (i[1]*multiplier)][horiPos + (i[0]*multiplier)] == board.turn):
					betterDirs.append(i)
					board.moves += 1
					selfSprite.texture = load("res://images/grey.png")
		#elif board.array[vertPos + (i[1]*multiplier)][horiPos + (i[0]*multiplier)] == 0:
		#	continue

# What was I thinking? This is the worst code I've ever made. Subject for deletion
func checkValidMovement():
	dirs = []
	var tempHori = 0
	var tempVert = 0
	var direction = 0 # 0 is up, goes in clockwise movement 45 degrees every integer increasement
	var prevention = false
	var death = true
	if selfSprite.texture == load("res://images/black.png") or selfSprite.texture == load("res://images/white.png"):
		death = false
	while death:
		if (tempHori + horiPos > 7) or (tempVert + vertPos > 7) or (horiPos + tempHori < 0) or (vertPos + tempVert < 0):
			#print("Changing directions")
			tempHori = 0
			tempVert = 0
			direction += 1
			if direction == 8:
				death = false
		if (board.array[vertPos + tempVert][horiPos + tempHori] == board.turn) and not (tempHori == 0 and tempVert == 0):
			if (tempHori > 1 or tempHori < -1) or (tempVert > 1 or tempVert < -1):
				#print(horiPos,tempHori,vertPos,tempVert)
				#print(horiPos,vertPos)
				#print(direction)
				#print(board.array[vertPos + tempVert][horiPos + tempHori])
				#print("testing")
				dirs.append(direction)
				if selfSprite.texture == grey:
					pass
				else:
					board.moves += 1
				selfSprite.texture = load("res://images/grey.png")
				tempHori = 0
				tempVert = 0
				direction += 1
				prevention = true
			else:
				tempHori = 0
				tempVert = 0
				direction += 1
				prevention = true
		elif board.array[vertPos + tempVert][horiPos + tempHori] == 0 and not (tempHori == 0 and tempVert == 0):
			#print("Hitting air")
			tempHori = 0
			tempVert = 0
			direction += 1
			prevention = true
		if not prevention:
			if direction == 0:
				tempVert -= 1
				tempHori = 0
			if direction == 1:
				tempHori += 1
				tempVert -= 1
			if direction == 2:
				tempHori += 1
				tempVert = 0
			if direction == 3:
				tempHori += 1
				tempVert += 1
			if direction == 4:
				tempVert += 1
				tempHori = 0
			if direction == 5:
				tempVert += 1
				tempHori -= 1
			if direction == 6:
				tempHori -= 1
				tempVert = 0
			if direction == 7:
				tempHori -= 1
				tempVert -= 1
		if direction == 8:
			death = false
		prevention = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
