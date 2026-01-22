extends Area2D

@onready var board = get_node("../../North Board")
@onready var otherBoard = get_node("../../South Board")
var col: int
var row: int
var sprite: Sprite2D
var north: bool
var value := 0
var empty = preload("res://images/Dice/empty.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		
		
		if north:
			if board.turn == 0:
				if sprite.texture == empty and row > 0:
					if board.array[row-1][col].sprite.texture != empty:
						var loadtext = "res://images/Dice/" + str(int(board.die)) + ".png"
						value = board.die
						board.checkOtherSide(board.die,col)
						board.turn = 1
						board.getNewDie()
						otherBoard.selection()
						sprite.texture = load(loadtext)
					pass
				elif sprite.texture == empty:
					var loadtext = "res://images/Dice/" + str(int(board.die)) + ".png"
					sprite.texture = load(loadtext)
					value = board.die
					board.turn = 1
					board.checkOtherSide(board.die,col)
					board.getNewDie()
					otherBoard.selection()
					pass
		else:
			if board.turn == 1:
				if sprite.texture == empty and row > 0:
					if otherBoard.array[row-1][col].sprite.texture != empty:
						var loadtext = "res://images/Dice/" + str(int(board.die)) + ".png"
						value = board.die
						otherBoard.checkOtherSide(board.die,col)
						board.getNewDie()
						board.selection()
						board.turn = 0
						sprite.texture = load(loadtext)
					pass
				elif sprite.texture == empty:
					var loadtext = "res://images/Dice/" + str(int(board.die)) + ".png"
					sprite.texture = load(loadtext)
					value = board.die
					board.turn = 0
					board.selection()
					otherBoard.checkOtherSide(board.die,col)
					board.getNewDie()
					pass
		if north:
			for i in get_node("../../North Score").get_children():
				i.calculateScore()
			var completed = true
			for i in board.get_children():
				if i.sprite.texture == load("res://images/Dice/empty.png"):
					completed = false
			if completed:
				print("Finished game")
				calFinalScore()
		else:
			for i in get_node("../../South Score").get_children():
				i.calculateOtherScore()
			var completed = true
			for i in otherBoard.get_children():
				if i.sprite.texture == load("res://images/Dice/empty.png"):
					completed = false
			if completed:
				print("Finished game")
				calFinalScore()
	pass

func calFinalScore():
	var northScore = 0
	var southScore = 0
	for i in get_node("../../South Score").get_children():
		southScore += int(i.get_text())
	for i in get_node("../../North Score").get_children():
		northScore += int(i.get_text())
	if northScore > southScore:
		get_node("../../North Conf").emitting = true
	elif southScore > northScore:
		get_node("../../South Conf").emitting = true
	else:
		get_node("../../North Conf").emitting = true
		get_node("../../South Conf").emitting = true
	get_node("../../Timer").start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
