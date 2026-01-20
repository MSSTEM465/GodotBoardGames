extends Label
var started = false
var timeStarted: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start():
	started = true
	timeStarted = int(Time.get_unix_time_from_system())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		var finalTime = int(Time.get_unix_time_from_system()) - timeStarted
		if len(str(finalTime)) > 3:
			finalTime = int(999)
		if len(str(finalTime)) == 1:
			finalTime = '0' + '0' + str(finalTime)
		elif len(str(finalTime)) == 2:
			finalTime = '0' + str(finalTime)
		else:
			finalTime = str(finalTime)
		set_text(str(finalTime))
		pass
