extends Node

var loading_screen_packed = preload("res://loading.tscn")
var loading_screen_instance = null
var scene_to_load_path: String
var current_load_status: int
var progress: Array = []

func load_scene(path: String):
	scene_to_load_path = path
	loading_screen_instance = loading_screen_packed.instantiate()
	get_tree().current_scene.add_child(loading_screen_instance)
	ResourceLoader.load_threaded_request(scene_to_load_path)

func _process(delta):
	if loading_screen_instance != null:
		current_load_status = ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)
		
		if current_load_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if not progress.is_empty():
				loading_screen_instance.get_node("ProgressBar").value = progress[0] * 100
		
		if current_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene = ResourceLoader.load_threaded_get(scene_to_load_path)
			get_tree().change_scene_to_packed(new_scene)
			loading_screen_instance.queue_free()
			loading_screen_instance = null
