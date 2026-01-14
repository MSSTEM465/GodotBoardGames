extends Control

var stories = []
var inGame = false
var completedStories = []
var story_data := "user://story_data.ini"
var data = ConfigFile.new()
var currentStory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# https://forum.godotengine.org/t/how-can-i-get-the-list-of-files-inside-a-folder/83595/2
	var dir := DirAccess.open("res://storyModeNonograms")
	if dir == null: printerr("Could not open folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		stories.append(file)
		
	if data.load(story_data):
		data.set_value("Progress","Complete",[])
		data.save(story_data)
		print("Saving Data")
		print(data)
	else:
		print("Loading Data")
		for i in data.get_value("Progress","Complete"):
			print("Adding value into completed array")
			print(i)
			completedStories.append(i)
	
	generateStories()
	pass # Replace with function body.

func generateStories():
	#self.global_position = Vector2i(get_viewport().size.x/2,get_viewport().size.y/2)
	for i in range(len(stories)):
		var area = Area2D.new()
		var colli = CollisionShape2D.new()
		var sizeC = RectangleShape2D.new()
		sizeC.size = Vector2(100,100)
		colli.shape = sizeC
		area.add_child(colli)
		var sprite = Sprite2D.new()
		if stories[i] in data.get_value("Progress","Complete"):
			sprite.texture = load("res://images/nodecomplete.png")
		else:
			sprite.texture = load("res://images/node.png")
		var label = Label.new()
		area.add_child(sprite)
		area.add_child(label)
		area.set_script(load("res://scripts/forStoryNodes.gd"))
		area.sprite = sprite
		area.id = i
		self.add_child(area)
		label.set_text(str(i+1))
		label.add_theme_font_size_override("font_size",30)
		label.add_theme_color_override("font_color", "black")
		label.global_position = sprite.position - Vector2(9,20)
		colli.global_position = sprite.position
		area.global_position = Vector2(get_viewport().size.x/2,i*200+200)
		#get_node("../../ScrollContainer").set_v_scroll(area.global_position.y + 100)
		self.set_custom_minimum_size(Vector2(100,area.global_position.y+500))
		area.update()
		#if i % 2 == 0:
			#completedStories.append(stories[i])
			#data.set_value("Progress","Complete",[])
		#print(data.get_value("Progress","Complete"))
	#data.save(story_data)
	
func wipeData():
	completedStories = []
	data.set_value("Progress","Complete",[])
	data.save(story_data)
	for i in get_children():
		i.update()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
