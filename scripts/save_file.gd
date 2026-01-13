extends FileDialog
var heyMan = false

@onready var cb = get_node("../CreateBoard")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_file_selected(path: String) -> void:
	cb.saveFile(path)


func _on_about_to_popup() -> void:
	heyMan = true
	pass # Replace with function body.


func _on_confirmed() -> void:
	heyMan = false
	pass # Replace with function body.


func _on_canceled() -> void:
	heyMan = false
	pass # Replace with function body.
