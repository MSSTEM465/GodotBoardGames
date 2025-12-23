extends Node

var array=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func createBoard(size):
	for n in get_children():
		n.queue_free()
	array = []
	for i in range(size[0]):
		
		array.append([])
		array[i] = []
		for o in range(size[1]):
			array[i].append([])
			array[i][o] = 0
			var area := Area2D.new()
			area.set_script(load("res://scripts/forGrid.gd"))
			add_child(area)

			var sprite := Sprite2D.new()
			sprite.texture = load("res://images/empty.png")
			sprite.position = Vector2(i * 50, o * 50)
			area.add_child(sprite)
			
			area.sprite = sprite
			area.x = o
			area.y = i

			var collision := CollisionShape2D.new()
			var shape := RectangleShape2D.new()
			var hintX := RichTextLabel.new()
			var hintY := RichTextLabel.new()
			if i == 0:
				hintX = RichTextLabel.new()
				hintX.set_text("0")
				hintX.global_position = Vector2(sprite.position.x+25,sprite.position.y-30)
				area.add_child(hintX)
			if o == 0:
				hintY = RichTextLabel.new()
				hintY.set_text("0")
				hintY.global_position = Vector2(sprite.position.x-30,sprite.position.y+25)
				area.add_child(hintY)
			shape.size = Vector2(50, 50)
			collision.shape = shape
			collision.position = sprite.position
			area.add_child(collision)
	print(array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
