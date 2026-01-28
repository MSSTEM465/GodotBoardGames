extends Area2D
@onready var hider = get_node("../Hider")
@onready var board = get_node("../Ship View")
@onready var peg = get_node("../peg")
var stopper = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not hider.visible:
		if board.endGame:
			board.preStage = true
			board.endGame = false
			board.initialize()
			board.turn = 0
			get_node("../Ship Selection").show()
			get_node("../Map").generate()
			get_node("../Label").set_text("Your Board")
			get_node("../Label2").set_text("Enemy Map")
			get_node("../Player").set_text("Player 1")
			return
		if board.preStage:
			if board.turn == 0:
				var count = 0
				for i in board.p1ShipArray:
					for j in i:
						if j == 2 or j == 3:
							count += 1
				if count == 5:
					pass
				elif count < 5:
					return
				else:
					print("What the hell did you do")
			if board.turn == 1:
				var count = 0
				for i in board.p2ShipArray:
					for j in i:
						if j == 2 or j == 3:
							count += 1
				if count == 5:
					pass
				elif count < 5:
					return
				else:
					print("What the hell did you do")
		hider.show()
		if board.preStage and board.turn == 1:
			board.preStage = false
			stopper = true
			get_node("../Hider/Warn").set_text("Time to shoot!")
		elif board.preStage and board.turn == 0:
			pass
		if board.turn == 0:
			board.turn = 1
			get_node("../Player").set_text("Player 2")
		elif board.turn == 1:
			board.turn = 0
			get_node("../Player").set_text("Player 1")
		peg.position = Vector2(9999,9999)
		if board.preStage == false:
			get_node("../Map").generate()
			get_node("../Ship Selection").hide()
			if board.turn == 1:
				if not board.p2ShipArray[peg.verPos][peg.horPos] == 0:
					var text = board.list[peg.horPos] + str(peg.verPos + 1) + " was struck. HIT!"
					board.p1ShotArray[peg.verPos][peg.horPos] = 2
					get_node("../Hider/Warn").set_text(text)
					if board.shipCheckSunk(peg.verPos,peg.horPos,1):
						text = board.list[peg.horPos] + str(peg.verPos + 1) + " was HIT! SUNK!!!"
						get_node("../Hider/Warn").set_text(text)
				else:
					var text = board.list[peg.horPos] + str(peg.verPos + 1) + " was struck. Miss!"
					board.p1ShotArray[peg.verPos][peg.horPos] = 1
					get_node("../Hider/Warn").set_text(text)
			else:
				if not stopper:
					if not board.p1ShipArray[peg.verPos][peg.horPos] == 0:
						var text = board.list[peg.horPos] + str(peg.verPos + 1) + " was struck. HIT!"
						get_node("../Hider/Warn").set_text(text)
						board.p2ShotArray[peg.verPos][peg.horPos] = 2
						if board.shipCheckSunk(peg.verPos,peg.horPos,0):
							text = board.list[peg.horPos] + str(peg.verPos + 1) + " was HIT! SUNK!!!"
							get_node("../Hider/Warn").set_text(text)
					else:
						var text = board.list[peg.horPos] + str(peg.verPos + 1) + " was struck. Miss!"
						get_node("../Hider/Warn").set_text(text)
						board.p2ShotArray[peg.verPos][peg.horPos] = 1
			board.generateWithInfo()
			if board.checkWon():
				board.showP1()
				get_node("../Map").showP2()
				get_node("../Hider").hide()
				get_node("../Player").set_text("")
				get_node("../Label").set_text("Player 1")
				get_node("../Label2").set_text("Player 2")
				board.endGame = true
				return
		else:
			board.generate()
		stopper = false
