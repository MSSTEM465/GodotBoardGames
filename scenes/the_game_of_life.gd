extends Node2D

var board: Array
var newBoard: Array
var objectBoard: Array
var simulating := false
var yes = preload("res://images/life/yes.png")
var no = preload("res://images/life/no.png")
var theScript = preload("res://scripts/cellsoflife.gd")
var size: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func create(s1,s2):
	size = s1
	self.hide()
	board = []
	newBoard = []
	objectBoard = []
	var shape = RectangleShape2D.new()
	shape.size = Vector2(25,25)
	for i in range(s1):
		board.append([])
		newBoard.append([])
		objectBoard.append([])
		for j in range(s2):
			board[i].append(false)
			newBoard[i].append(false)
			var area = Area2D.new()
			var coll = CollisionShape2D.new()
			var sprite = Sprite2D.new()
			sprite.texture = no
			coll.shape = shape
			area.add_child(coll)
			area.add_child(sprite)
			area.set_script(theScript)
			area.horLeng = j
			area.verLeng = i
			area.on = false
			area.sprite = sprite
			objectBoard[i].append(area)
			area.position = Vector2(j*25,i*25)
			self.add_child(area)
			if j % 100 == 0:
				await get_tree().process_frame
			
	self.show()
	#newBoard = board.duplicate()
	
func _input(event):
	if event.is_action("movedown"):
		self.position.y -= 10
	if event.is_action("moveup"):
		self.position.y += 10
	if event.is_action("moveleft"):
		self.position.x -= 10
	if event.is_action("moveright"):
		self.position.x += 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if simulating:
		for i in get_children(): # This is a stupid idea LOL
			i.calculateChange()
		for i in range(len(board)):
			for j in range(len(board[i])):
				board[i][j] = newBoard[i][j]
		#board = newBoard.duplicate()
	pass
