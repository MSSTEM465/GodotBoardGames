extends Area2D

var horiPos: int
var vertPos: int
var Ship := "None"
var ShipRotation := 0

@onready var sea = get_node("../../Ship View")
@onready var mS = get_node("../../Mouse Ship")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and sea.preStage:
		if mS.shipSelected == "Cruiser":
			if sea.checkValidity([vertPos,horiPos],mS.shipSelected,mS.rotation_degrees == 90):
				#if (horiPos + 1 < 10 and mS.rotation_degrees == 0) or (vertPos + 1 < 10 and mS.rotation_degrees == 90):
					var sprite = Sprite2D.new()
					sprite.texture = load("res://images/battleship/cruiser.png")
					sprite.z_index = 30
					sprite.rotation_degrees = mS.rotation_degrees
					self.add_child(sprite)
					Ship = "Cruiser"
					ShipRotation = mS.rotation_degrees
					mS.shipSelected = "None"
					mS.hide()
		elif mS.shipSelected == "Destroyer":
			if sea.checkValidity([vertPos,horiPos],mS.shipSelected,mS.rotation_degrees == 90):
				#if horiPos + 1 < 10 and horiPos - 1 > 0:
					var sprite = Sprite2D.new()
					sprite.texture = load("res://images/battleship/destroyer.png")
					sprite.z_index = 30
					sprite.rotation_degrees = mS.rotation_degrees
					self.add_child(sprite)
					Ship = "Destroyer"
					ShipRotation = mS.rotation_degrees
					mS.shipSelected = "None"
					mS.hide()
		elif mS.shipSelected == "Battleship":
			if sea.checkValidity([vertPos,horiPos],mS.shipSelected,mS.rotation_degrees == 90):
				var sprite = Sprite2D.new()
				sprite.texture = load("res://images/battleship/battleship.png")
				sprite.z_index = 30
				sprite.rotation_degrees = mS.rotation_degrees
				self.add_child(sprite)
				Ship = "Battleship"
				ShipRotation = mS.rotation_degrees
				mS.shipSelected = "None"
				mS.hide()
		elif mS.shipSelected == "Carrier":
			if sea.checkValidity([vertPos,horiPos],mS.shipSelected,mS.rotation_degrees == 90):
				var sprite = Sprite2D.new()
				sprite.texture = load("res://images/battleship/carrier.png")
				sprite.z_index = 30
				sprite.rotation_degrees = mS.rotation_degrees
				Ship = "Carrier"
				ShipRotation = mS.rotation_degrees
				self.add_child(sprite)
				mS.shipSelected = "None"
				mS.hide()
		elif mS.shipSelected == "Submarine":
			if sea.checkValidity([vertPos,horiPos],mS.shipSelected,mS.rotation_degrees == 90):
				var sprite = Sprite2D.new()
				sprite.texture = load("res://images/battleship/submarine.png")
				sprite.z_index = 30
				sprite.rotation_degrees = mS.rotation_degrees
				Ship = "Submarine"
				ShipRotation = mS.rotation_degrees
				self.add_child(sprite)
				mS.shipSelected = "None"
				mS.hide()
		sea.updateArrayRewrite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
