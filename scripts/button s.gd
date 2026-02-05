extends Area2D

@onready var IB = get_node("../InfoButton")
@onready var CB = get_node("../CreateButton")
@onready var PB = get_node("../PlayButton")
@onready var SB = get_node("../StoryButton")

@onready var ImEx = get_node("../Import and Export")
@onready var ImExSprite = get_node("../Import and Export/ImExport")
@onready var info = get_node("../Info")
@onready var warnings = get_node("../Warnings")
@onready var Settings = get_node("../Settings Icon")
@onready var SettingsPage = get_node("../SettingsPage")
@onready var HorLeng = get_node("../HorLeng")
@onready var VerLeng = get_node("../VerLeng")
@onready var Generate = get_node("../Generate")
@onready var Scroller = get_node("../Campaign")
@onready var LevelInfo = get_node("../LevelInfo")
@onready var Locked = get_node("../locked")

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
		if self == CB and not Locked.visible:
			LevelInfo.hide()
			info.hide()
			warnings.hide()
			HorLeng.show()
			VerLeng.show()
			Generate.show()
			PlayBoard.hide()
			CreateBoard.show()
			Settings.hide()
			ImExSprite.texture = load("res://images/Export.png")
			Scroller.hide()
			get_node("../Back").hide()
		if self == PB and not Locked.visible:
			LevelInfo.hide()
			get_node("../Back").hide()
			info.hide()
			warnings.show()
			HorLeng.hide()
			VerLeng.hide()
			Generate.hide()
			CreateBoard.hide()
			if Scroller.get_node("Control").inGame:
				ImEx.hide()
				pass # Replace with warning or sfx
			else:
				PlayBoard.show()
				Settings.show()
				ImExSprite.texture = load("res://images/Import.png")
				Scroller.hide()
		if self == IB:
			LevelInfo.hide()
			info.show()
			warnings.hide()
			HorLeng.hide()
			VerLeng.hide()
			Generate.hide()
			Settings.hide()
			CreateBoard.hide()
			PlayBoard.hide()
			ImEx.hide()
			Scroller.hide()
			get_node("../Back").hide()
		if self == SB:
			LevelInfo.hide()
			info.hide()
			warnings.hide()
			HorLeng.hide()
			VerLeng.hide()
			Generate.hide()
			Settings.hide()
			CreateBoard.hide()
			PlayBoard.hide()
			ImEx.hide()
			get_node("../Back").hide()
			if Scroller.get_node("Control").inGame:
				get_node("../Back").show()
				PlayBoard.show()
			else:
				if not Scroller.get_node("Control").data.get_value("Progress","Complete") == []:
					ImEx.show()
				ImExSprite.texture = load("res://images/reset.png")
				Scroller.show()
	pass # Replace with function body.
