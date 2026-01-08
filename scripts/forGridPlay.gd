extends Area2D

@onready var PlayBoard = get_node("../../PlayBoard")
@onready var warnings = get_node("../../Warnings")

var hori: int
var vert: int
var sprite: Sprite2D
var primed: bool
var corrected = false
var empty := preload("res://images/empty.png")
var marked := preload("res://images/marked.png")
var filled := preload("res://images/filled.png")
var nope := preload("res://images/nope.png")
var labels: Array
var leftHold = false
var rightHold = false
var middleHold = false

# Called when the node enters the scene tree for the first time.
func _ready():
	input_event.connect(_on_input_event)

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("fill"):
			leftHold = true
		if event.is_action_pressed("empty"):
			rightHold = true
		if event.is_action_pressed("middle"):
			middleHold = true
		if event.is_action_released("fill"):
			leftHold = false
		if event.is_action_released("empty"):
			rightHold = false
		if event.is_action_released("middle"):
			middleHold = false

func _on_input_event(viewport, event, shape_idx):
		
		if leftHold and not sprite.texture == marked:
			sprite.texture = filled
			PlayBoard.arraySelected[vert][hori] = 1
		elif middleHold and not sprite.texture == marked:
			sprite.texture = empty
			PlayBoard.arraySelected[vert][hori] = 0
		elif rightHold and not sprite.texture == marked:
			sprite.texture = nope
			PlayBoard.arraySelected[vert][hori] = 0
			
		if PlayBoard.autofill:
			if PlayBoard.arraySelected[vert] == PlayBoard.arraySolution[vert]:
				for i in PlayBoard.get_children():
					if i.vert == vert and i.sprite.texture == empty:
						i.sprite.texture = nope
						i.corrected = true
			var columnLaneSol = []
			var columnLaneSel = []
			for row in PlayBoard.arraySolution:
				if hori >= 0 and hori < PlayBoard.arraySolution[0].size():
					columnLaneSol.append(row[hori])
				else:
					break
					
			for row in PlayBoard.arraySelected:
				if hori >= 0 and hori < PlayBoard.arraySelected[0].size():
					columnLaneSel.append(row[hori])
				else:
					break
					
			if columnLaneSol == columnLaneSel:
				for h in PlayBoard.get_children():
					if h.hori == hori and h.sprite.texture == empty:
						h.sprite.texture = nope
						h.corrected = true
		if PlayBoard.correction:
			if leftHold or middleHold or rightHold:
				
				if not PlayBoard.arraySelected[vert][hori] == PlayBoard.arraySolution[vert][hori]:
					if not corrected:
						warnings.set_text("Incorrect!")
						if PlayBoard.penalize:
							PlayBoard.lives -= 1
							var string = "Incorrect!\nYou now have\n" + str(PlayBoard.lives)+ " lives left."
							warnings.set_text(string)
							if PlayBoard.lives == 0:
								warnings.set_text("You have failed!")
								PlayBoard.niceOneIdiot()
					if PlayBoard.arraySolution[vert][hori] == 2: # Wont penalize or try to correct when clicking on a two
						pass
					elif PlayBoard.arraySolution[vert][hori] == 1:
						PlayBoard.arraySelected[vert][hori] = 1 
						corrected = true
						sprite.texture = filled
					elif PlayBoard.arraySolution[vert][hori] == 0:
						PlayBoard.arraySelected[vert][hori] = 0
						corrected = true
						sprite.texture = nope
						
					# Will prevent user from being yelled at by the program by holding and shaking the mouse around
					leftHold = false
					rightHold = false
					middleHold = false
				else:
					warnings.set_text("")
		if PlayBoard.arraySelected == PlayBoard.arraySolution and not PlayBoard.completed:
			PlayBoard.completed = true
			warnings.set_text("You win!")
			var confL = get_node("../../ConfetLeft")
			var confR = get_node("../../ConfetRight")
			confR.emitting = true
			confL.emitting = true
	#print(CreateBoard.array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
