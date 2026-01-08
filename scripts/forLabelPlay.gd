extends Label

@onready var PlayBoard = get_node("../../../PlayBoard")
@onready var location: int
@onready var ifVert: bool

var lane = []
var result
var counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update():
	lane = []
	if ifVert:
		lane = PlayBoard.arraySolution[location]
	else:
		for row in PlayBoard.arraySolution:
			if location >= 0 and location < PlayBoard.arraySolution[0].size():
				lane.append(row[location])
			else:
				break
	var i
	result = ""
	counter = 0
	for h in range(len(lane)):
		i = lane[h]
		if i == 1:
			counter += 1
			if h+2 > len(lane):
				if len(result) == 0:
					result = str(counter)
				else:
					result = result + ", " + str(counter)
		elif counter > 0 and (i == 0 or i == 2):
			if len(result) == 0:
				result = str(counter)
			else:
				result = result + ", " + str(counter)
			counter = 0
	if len(result) == 0:
		result = "0"
	if not ifVert:
		result = result.replace(", ","\n")
	#print(result)
	self.set_text(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
