extends Area2D
@onready var infoBoard = get_node("../../Info")
@onready var title = get_node("../../Info/Title")
@onready var desc = get_node("../../Info/Desc")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Knucklebones
func _on_mouse_entered() -> void:
	infoBoard.position = self.global_position
	title.set_text("Knucklebones")
	desc.set_text("A port of the minigame in Cult of the Lamb! Compete with an opponent using dice on two 3 by 3 boards. Place your roll in a column, and switch to the next player. If a die matches with another die in the opponents board, all die with that value disappears. If you manage to stack two or more die with the same value, they multiply! Once someone uses up all the space, they ends the game, and the player with the most points win.")
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	infoBoard.position = Vector2(0,0)
	pass # Replace with function body.

# Nonograms
func _on_info_mouse_entered() -> void:
	infoBoard.position = self.global_position + Vector2(0,-10)
	title.set_text("Nonograms")
	desc.set_text("A simple grid based game. Each column and row is accompanited with a number representing the list of unbroken cells, read top to bottom or left to right.")
	pass # Replace with function body.

# Reversi
func _on_reversi_info_mouse_entered() -> void:
	infoBoard.position = self.global_position + Vector2(550,-10)
	title.set_text("Reversi")
	desc.set_text("Also known as Fellow or Othello. A simple yet competive board game. When a tile is placed, every row, column, and diagonal which follows with the opposite color and hits the same color gets flipped to the players color. Player with the most tiles covered with their color wins!")
	pass # Replace with function body.

# Minesweeper
func _on_minesweeper_info_mouse_entered() -> void:
	infoBoard.position = self.global_position + Vector2(550,0)
	title.set_text("Minesweeper")
	desc.set_text("Avoid the mines in the famous Minesweeper! Choose your board difficulty, then start clearing mines! Each open cell says how many neighboring cells is a mine. For example, if you have a cell with the number 3, exactly 3 cells around it is a mine.")
	pass # Replace with function body.

# Battleship
func _on_battleship_info_mouse_entered() -> void:
	infoBoard.position = self.global_position + Vector2(325,-10)
	title.set_text("Battleship")
	desc.set_text("The popular board game! Each player first sets up their board, and then they battle it out! Click on a ship to select, and click on the left board to place. Shoot by selecting the tile you want to hit on the right, and continue to the next round. Results of the shot is shown on the page in between!")
	pass # Replace with function body.

# GOL
func _on_gol_info_mouse_entered() -> void:
	infoBoard.position = self.global_position + Vector2(325,0)
	title.set_text("Game of Life")
	desc.set_text("Set up a board and start the simulation to see it move! Each cell checks if it surrounds a certain number of on cells. Depending on if itself is on, it can change. If on, if it has less than 2 on cells around it or more than three cells, it turns off. Else, it stays on. If off, if it has exactly three cells around it on, it turns on.")
	pass # Replace with function body.
