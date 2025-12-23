extends Area2D

var sprite: Sprite2D
var x: int
var y: int
@onready var PlayBoard = get_node("../../PlayBoard")
var empty := preload("res://images/empty.png")
var filled := preload("res://images/filled.png")
var nope := preload("res://images/dunno.png")

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print(sprite)
			if sprite.texture == filled:
				sprite.texture = empty
				PlayBoard.arraySelected[x][y] = 0
			elif sprite.texture == empty:
				sprite.texture = filled
				PlayBoard.arraySelected[x][y] = 1
		if event.button_index == MOUSE_BUTTON_RIGHT:
			sprite.texture = nope
			PlayBoard.arraySelected[x][y] = 0
		if PlayBoard.arraySelected == PlayBoard.arrayPlay:
			print("ya won buster")
		
	print(PlayBoard.arraySelected)
	print(PlayBoard.arrayPlay)
		
