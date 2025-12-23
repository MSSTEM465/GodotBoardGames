extends Area2D

var sprite: Sprite2D
var x: int
var y: int
@onready var CreateBoard = get_node("../../CreateBoard")
var empty := preload("res://images/empty.png")
var marked := preload("res://images/marked.png")
var filled := preload("res://images/filled.png")

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print(sprite)
			if sprite.texture == filled:
				sprite.texture = empty
				CreateBoard.array[x][y] = 0
			elif sprite.texture == empty:
				sprite.texture = filled
				CreateBoard.array[x][y] = 1
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			sprite.texture = marked
			CreateBoard.array[x][y] = 2
	print(CreateBoard.array)
		
