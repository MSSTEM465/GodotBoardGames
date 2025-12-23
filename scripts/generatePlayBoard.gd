extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func createBoard(size):
	for i in range(size[0]):
		for o in range(size[1]):
			# 1. Create a new Sprite2D instance
			print(100 + (i*50), 100 + (i*50))
			var sprite = Sprite2D.new()

			# 2. Load the image resource from your project files
			# The path should be relative to the 'res://' directory
			var texture = load("res://empty.png") # Replace "res://icon.png" with your image path

			# 3. Assign the loaded texture to the sprite's texture property
			sprite.texture = texture

			# 4. (Optional) Set the sprite's position
			sprite.position = Vector2((i*50), (o*50)) # Sets the position in local coordinates

			# 5. Add the new sprite as a child of the current node (the one the script is attached to)
			add_child(sprite)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
