extends Area2D

@onready var s1 = get_node("../Cruiser")
@onready var s2 = get_node("../Destroyer")
@onready var s3 = get_node("../Submarine")
@onready var s4 = get_node("../Battleship")
@onready var s5 = get_node("../Carrier")
@onready var mS = get_node("../../Mouse Ship")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		mS.show()
		if self == s1:
			mS.texture = load("res://images/battleship/cruiser.png")
			mS.shipSelected = "Cruiser"
			for i in get_node("../../Ship View").get_children():
				for g in i.get_children():
					if g is Sprite2D:
						if g.texture == load("res://images/battleship/cruiser.png"):
							i.Ship = "None"
							g.queue_free()
			get_node("../../Ship View").updateArrayRewrite()
			
		elif self == s2:
			mS.texture = load("res://images/battleship/destroyer.png")
			mS.shipSelected = "Destroyer"
			for i in get_node("../../Ship View").get_children():
				for g in i.get_children():
					if g is Sprite2D:
						if g.texture == load("res://images/battleship/destroyer.png"):
							i.Ship = "None"
							g.queue_free()
			get_node("../../Ship View").updateArrayRewrite()
		elif self == s3:
			mS.texture = load("res://images/battleship/submarine.png")
			mS.shipSelected = "Submarine"
			for i in get_node("../../Ship View").get_children():
				for g in i.get_children():
					if g is Sprite2D:
						if g.texture == load("res://images/battleship/submarine.png"):
							i.Ship = "None"
							g.queue_free()
			get_node("../../Ship View").updateArrayRewrite()
		elif self == s4:
			mS.texture = load("res://images/battleship/battleship.png")
			mS.shipSelected = "Battleship"
			for i in get_node("../../Ship View").get_children():
				for g in i.get_children():
					if g is Sprite2D:
						if g.texture == load("res://images/battleship/battleship.png"):
							i.Ship = "None"
							g.queue_free()
			get_node("../../Ship View").updateArrayRewrite()
		elif self == s5:
			mS.texture = load("res://images/battleship/carrier.png")
			mS.shipSelected = "Carrier"
			for i in get_node("../../Ship View").get_children():
				for g in i.get_children():
					if g is Sprite2D:
						if g.texture == load("res://images/battleship/carrier.png"):
							i.Ship = "None"
							g.queue_free()
			get_node("../../Ship View").updateArrayRewrite()
	pass # Replace with function body.
