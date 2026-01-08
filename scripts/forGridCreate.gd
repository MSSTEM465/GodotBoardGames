extends Area2D

@onready var CreateBoard = get_node("../../CreateBoard")

var hori: int
var vert: int
var sprite: Sprite2D
var primed: bool
var empty := preload("res://images/empty.png")
var marked := preload("res://images/marked.png")
var filled := preload("res://images/filled.png")
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

		if leftHold:
			sprite.texture = filled
			CreateBoard.array[vert][hori] = 1
		elif rightHold:
			sprite.texture = marked
			CreateBoard.array[vert][hori] = 2
		elif middleHold:
			sprite.texture = empty
			CreateBoard.array[vert][hori] = 0
		for i in labels:
			i.update()
	#print(CreateBoard.array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
