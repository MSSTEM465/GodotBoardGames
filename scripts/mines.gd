extends Area2D # MINESWEEPER
@onready var field = get_node("../../field")
@onready var audioPlayer = get_node("../../AudioStreamPlayer2D")
var unrevealed = preload("res://images/minesweeper/click.png")
var vertPos: int
var horiPos: int
var sprite: Sprite2D
var revealed := false
var flagged := false
var emptySpace = true
var checked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func reveal():
	if not revealed and not flagged: # just prevents infinite loops from empty spaces
		revealed = true
		if field.array[vertPos][horiPos] == 1:
			print("mine")
			field.failure()
			sprite.texture = load("res://images/minesweeper/mine.png")
			get_node("../../explosion").position = self.global_position
			get_node("../../explosion").emitting = true
			audioPlayer.play()
		else:
			var direction = 0
			var list = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
			var count = 0
			for i in range(8):
				if (vertPos + list[i][0] <= field.siz[0]-1 and horiPos + list[i][1] <= field.siz[1]-1) and (vertPos + list[i][0] >= 0 and horiPos + list[i][1] >= 0):
					if field.array[vertPos + list[i][0]][horiPos + list[i][1]] == 1:
						count += 1
			if count == 0:
				for i in range(8):
					if (vertPos + list[i][0] <= field.siz[0]-1 and horiPos + list[i][1] <= field.siz[1]-1) and (vertPos + list[i][0] >= 0 and horiPos + list[i][1] >= 0):
						if field.areaArray[vertPos + list[i][0]][horiPos + list[i][1]].revealed == false:
							field.areaArray[vertPos + list[i][0]][horiPos + list[i][1]].reveal()
			sprite.texture = load("res://images/minesweeper/" + str(count) + ".png")
			
func revealAround():
	var list = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
	for i in range(8):
		if (vertPos + list[i][0] <= field.siz[0]-1 and horiPos + list[i][1] <= field.siz[1]-1) and (vertPos + list[i][0] >= 0 and horiPos + list[i][1] >= 0):
			if field.areaArray[vertPos + list[i][0]][horiPos + list[i][1]].revealed == false:
				field.areaArray[vertPos + list[i][0]][horiPos + list[i][1]].reveal()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.is_action("middle") and not revealed:
			if flagged:
				sprite.texture = unrevealed
				flagged = not flagged
			else:
				sprite.texture = load("res://images/minesweeper/flag.png")
				flagged = not flagged
		if event.is_action("fill"):
			if not get_node("../../Stopwatch").started:
				get_node("../../Stopwatch").start()
			if not sprite.texture == unrevealed and not flagged:
				revealAround()
			else:
				reveal()
		get_node("../../FlagCount").recount()
	pass
	
func checkAround():
	if emptySpace and not checked:
		checked = true
		field.emptyCount += 1
		var list = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]
		for i in range(8):
			if (vertPos + list[i][0] <= field.siz[0]-1 and horiPos + list[i][1] <= field.siz[1]-1) and (vertPos + list[i][0] >= 0 and horiPos + list[i][1] >= 0):
				field.areaArray[vertPos + list[i][0]][horiPos + list[i][1]].checkAround()
				#print([vertPos + list[i][0]],[horiPos + list[i][1]])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
