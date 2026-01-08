extends Area2D

@onready var IB = get_node("../InfoButton")
@onready var CB = get_node("../CreateButton")
@onready var PB = get_node("../PlayButton")

@onready var ImEx = get_node("../Import and Export")
@onready var ImExSprite = get_node("../Import and Export/ImExport")
@onready var Settings = get_node("../Settings Icon")
@onready var SettingsPage = get_node("../SettingsPage")
@onready var HorLeng = get_node("../HorLeng")
@onready var VerLeng = get_node("../VerLeng")
@onready var Generate = get_node("../Generate")

@onready var PlayBoard = get_node("../PlayBoard")
@onready var CreateBoard = get_node("../CreateBoard")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not SettingsPage.visible:
		ImEx.show()
		if self == CB:
			HorLeng.show()
			VerLeng.show()
			Generate.show()
			PlayBoard.hide()
			CreateBoard.show()
			Settings.hide()
			ImExSprite.texture = load("res://images/Export.png")
		if self == PB:
			HorLeng.hide()
			VerLeng.hide()
			Generate.hide()
			CreateBoard.hide()
			PlayBoard.show()
			Settings.show()
			ImExSprite.texture = load("res://images/Import.png")
		if self == IB:
			HorLeng.hide()
			VerLeng.hide()
			Generate.hide()
			Settings.hide()
			CreateBoard.hide()
			PlayBoard.hide()
			ImEx.hide()
	pass # Replace with function body.
