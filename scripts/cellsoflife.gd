extends Area2D

var horLeng: int
var verLeng: int
var on: bool
var sprite: Sprite2D
var yes = preload("res://images/life/yes.png")
var no = preload("res://images/life/no.png")
var direc = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
var count = 0 
@onready var board = get_node("../../theGame")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func whatisurproblem():
	count = 0
	for i in direc:
		if ((verLeng + i[0]) > -1 and (verLeng + i[0]) < len(board.board)):
			if ((horLeng + i[1]) > -1 and (horLeng + i[1]) < len(board.board)):
				if board.board[verLeng+i[0]][horLeng+i[1]]:
					count = count + 1
				elif on and not board.newBoard[verLeng+i[0]][horLeng+i[1]]: # Called if viewed object is off, but self is on
					board.objectBoard[verLeng+i[0]][horLeng+i[1]].imOffandMyFriendsAreOn()
	return count

func imOffandMyFriendsAreOn():
	count = 0
	#if on:
	#	print("Something terrible is going on. Fix yo damn code!!!")
	for i in direc:
		if ((verLeng + i[0]) > -1 and (verLeng + i[0]) < len(board.board)):
			if ((horLeng + i[1]) > -1 and (horLeng + i[1]) < len(board.board)):
				if board.board[verLeng+i[0]][horLeng+i[1]]:
					count = count + 1
	if count == 3:
		board.newBoard[verLeng][horLeng] = true
		on = true
	updateImage()

func calculateChange():
	#for i in direc:
		#if ((verLeng + i[0]) > -1 and (verLeng + i[0]) < 100):
			#if ((horLeng + i[1]) > -1 and (horLeng + i[1]) < 100):
				#if board.board[verLeng+i[0]][horLeng+i[1]]:
					#print(count)
					#if verLeng == 1 and horLeng == 1:
						#print("LOOK AT THIS")
						#print(whatisurproblem())
					#count = count + 1
	count = whatisurproblem()
	if on:
		if count < 2:
			board.newBoard[verLeng][horLeng] = false
			on = false
		elif count > 3:
			board.newBoard[verLeng][horLeng] = false
			on = false
	else:
		if count == 3:
			board.newBoard[verLeng][horLeng] = true
			on = true
	updateImage()

func updateImage():
	if on:
		sprite.texture = yes
	else:
		sprite.texture = no

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not board.simulating:
		on = not on
		board.board[verLeng][horLeng] = on
		board.newBoard[verLeng][horLeng] = on
		updateImage()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
