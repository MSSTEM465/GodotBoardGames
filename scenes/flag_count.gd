extends Label

@onready var field = get_node("../field")
var mineCount = 0
var flaggedCount = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func checkCompletion():
	for i in range(len(field.array)):
		for k in range(len(field.array[i])):
			if field.array[i][k] == 0 and field.areaArray[i][k].flagged:
				return false
			elif not field.areaArray[i][k].revealed and not field.areaArray[i][k].flagged:
				return false
	return true

func recount():
	mineCount = 0
	flaggedCount = 0
	for i in range(len(field.array)):
		for k in range(len(field.array[i])):
			if field.array[i][k] == 1:
				mineCount += 1
			if field.areaArray[i][k].flagged:
				flaggedCount += 1
	if (mineCount - flaggedCount) == 0:
		if checkCompletion():
			print("Win")
			get_node("../winner").emitting = true
			get_node("../Stopwatch").started = false
	var result: String
	if len(str(mineCount - flaggedCount)) == 1:
		result = '0' + '0' + str(mineCount - flaggedCount)
	elif len(str(mineCount - flaggedCount)) == 2:
		result = '0' + str(mineCount - flaggedCount)
	else:
		result = str(mineCount - flaggedCount)
	result = result.replace("-","- ")
	set_text(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
