extends Node2D
var turn = 0
var die = 1
var array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate()
	selection()
	pass # Replace with function body.

func checkOtherSide(die, col):
	for i in range(3):
		if get_node("../South Board").array[i][col].value == die:
			get_node("../South Board").array[i][col].value = 0
			get_node("../South Board").array[i][col].sprite.texture = load("res://images/Dice/empty.png")
	for c in range(2): # Does it again just in case
		for i in range(2):
			if get_node("../South Board").array[i][col].value == 0:
				get_node("../South Board").array[i][col].value = get_node("../South Board").array[i+1][col].value
				get_node("../South Board").array[i][col].sprite.texture = get_node("../South Board").array[i+1][col].sprite.texture
				get_node("../South Board").array[i+1][col].value = 0
				get_node("../South Board").array[i+1][col].sprite.texture = load("res://images/Dice/empty.png")
	for i in get_node("../South Score").get_children():
		i.calculateOtherScore()
		
func selection():
	get_node("../Selection").position = self.position + Vector2(-43,-245)

func getNewDie():
	die = int(round(randf_range(1,6)))
	get_node("../Die").texture = load("res://images/Dice/" + str(die) + ".png")

func generate():
	for i in get_children():
		i.queue_free()
	for i in get_node("../North Score").get_children():
		i.queue_free()
	getNewDie()
	array = []
	for i in range(3):
		array.append([])
		for j in range(3):
			var area = Area2D.new()
			array[i].append(area)
			var coll = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			shape.size = Vector2(50,50)
			var sprite = Sprite2D.new()
			sprite.texture = load("res://images/Dice/empty.png")
			coll.shape = shape
			area.add_child(coll)
			area.add_child(sprite)
			area.set_script(load("res://scripts/dice.gd"))
			self.add_child(area)
			area.col = j
			area.north = true
			area.row = i
			area.position = Vector2(j*50,i*-50)
			area.sprite = sprite
			if i == 2:
				var score = Label.new()
				score.set_text("0")
				score.add_theme_color_override("font_color", Color(0, 0, 0))
				score.add_theme_font_size_override("font_size", 30)
				score.set_script(load("res://scripts/scoreBone.gd"))
				score.col = j
				score.position = Vector2(j*100+40,10)
				get_node("../North Score").add_child(score)
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
