extends Node2D # BATTLESHIP
var list = ["A","B","C",'D','E',"F",'G','H','I',"J","K"]
@onready var board = get_node("../Ship View")
@onready var tile = preload("res://images/battleship/tile.png")
@onready var pegRed = preload("res://images/battleship/redPeg.png")
@onready var pegWhite = preload("res://images/battleship/whitePeg.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func generate():
	for i in get_children():
		i.queue_free()
	for i in range(10):
		for j in range(10):
			var area = Area2D.new()
			var sprite = Sprite2D.new()
			sprite.texture = load("res://images/battleship/tile.png")
			var shape = RectangleShape2D.new()
			shape.size = Vector2(50,50)
			var coll = CollisionShape2D.new()
			coll.shape = shape
			area.add_child(coll)
			area.add_child(sprite)
			area.position = Vector2(j*50,i*50)
			area.set_script(load("res://scripts/bsMap.gd"))
			area.horPos = j
			area.verPos = i
			self.add_child(area)
			if board.turn == 0:
				if board.p1ShotArray[i][j] == 1:
					var peg = Sprite2D.new()
					peg.texture = load("res://images/battleship/whitePeg.png")
					area.add_child(peg)
				elif board.p1ShotArray[i][j] == 2:
					var peg = Sprite2D.new()
					peg.texture = load("res://images/battleship/redPeg.png")
					area.add_child(peg)
			else:
				if board.p2ShotArray[i][j] == 1:
					var peg = Sprite2D.new()
					peg.texture = load("res://images/battleship/whitePeg.png")
					area.add_child(peg)
				elif board.p2ShotArray[i][j] == 2:
					var peg = Sprite2D.new()
					peg.texture = load("res://images/battleship/redPeg.png")
					area.add_child(peg)
			if i == 0:
				var label = Label.new()
				label.set_text(list[j])
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(j-10,-70)
				area.add_child(label)
			if j == 0:
				var label = Label.new()
				label.set_text(str(i+1))
				label.add_theme_color_override("font_color", Color(0, 0, 0))
				label.add_theme_font_size_override("font_size", 30)
				label.position = Vector2(-40,i-25)
				label.grow_horizontal = 0
				area.add_child(label)

func showP2():
	print("Started generating Player 2 map")
	print(Time.get_unix_time_from_system())
	for i in get_children():
		for j in i.get_children():
			if j is Sprite2D:
				if j.texture != tile:
					j.queue_free()
	#await get_tree().process_frame
	for i in range(10):
		#await get_tree().process_frame
		for j in range(10):
			#var area = Area2D.new()
			#var col = CollisionShape2D.new()
			#var shape = RectangleShape2D.new()
			#var sprite = Sprite2D.new()
			if board.p2ShipArray[i][j] == 2:
				var ship = Sprite2D.new()
				ship.texture = board.p2NamingArray[i][j]
				ship.rotation_degrees = 0
				ship.z_index = 30
				ship.position = Vector2(j*50,i*50)
				add_child(ship)
			if board.p2ShipArray[i][j] == 3:
				var ship = Sprite2D.new()
				ship.texture = board.p2NamingArray[i][j]
				ship.rotation_degrees = 90
				ship.z_index = 30
				ship.position = Vector2(j*50,i*50)
				add_child(ship)
			#shape.size = Vector2(50,50)
			#col.shape = shape
			#sprite.texture = tile
			#area.add_child(col)
			#area.add_child(sprite)
			#area.set_script(load("res://scripts/bsTiles.gd"))
			#area.horiPos = j
			#area.vertPos = i
			#sprite.position = Vector2(j*50,i*50)
			if board.p1ShotArray[i][j] == 1:
				var peg = Sprite2D.new()
				peg.z_index = 40
				peg.texture = pegWhite
				peg.position = Vector2(j*50,i*50)
				add_child(peg)
			elif board.p1ShotArray[i][j] == 2:
				var peg = Sprite2D.new()
				peg.z_index = 40
				peg.texture = pegRed
				peg.position = Vector2(j*50,i*50)
				add_child(peg)
			#self.add_child(sprite)
			#if i == 0:
				#var label = Label.new()
				#label.set_text(list[j])
				#label.add_theme_color_override("font_color", Color(0, 0, 0))
				#label.add_theme_font_size_override("font_size", 30)
				#label.position = Vector2(j-10,-70)
				#sprite.add_child(label)
			#if j == 0:
				#var label = Label.new()
				#label.set_text(str(i+1))
				#label.add_theme_color_override("font_color", Color(0, 0, 0))
				#label.add_theme_font_size_override("font_size", 30)
				#label.position = Vector2(-40,i-25)
				#label.grow_horizontal = 0
				#sprite.add_child(label)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
