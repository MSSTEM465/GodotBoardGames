extends Label

var col: int
@onready var board = get_node("../../North Board")
@onready var otherBoard = get_node("../../South Board")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func calculateOtherScore():
	var list = []
	var newList = [0,0,0]
	var result = 0
	for i in range(3):
		list.append(otherBoard.array[i][col].value)
	for i in range(3):
		print("Loop")
		print(list[i])
		print(list.count(list[i]))
		newList[i] = list[i] * list.count(list[i])
	for i in range(3):
		print(".")
		result += newList[i]
	set_text(str(result))


func calculateScore():
	var list = []
	var newList = [0,0,0]
	var result = 0
	for i in range(3):
		list.append(board.array[i][col].value)
	for i in range(3):
		print("Loop")
		print(list[i])
		print(list.count(list[i]))
		newList[i] = list[i] * list.count(list[i])
	for i in range(3):
		print(".")
		result += newList[i]
	set_text(str(result))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
