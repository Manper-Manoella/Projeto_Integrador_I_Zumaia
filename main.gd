extends Node2D

const TILE_SIZE = 64
const GRID_SIZE = 9
const OFFSET = Vector2(80,60)

var caminho = [
	Vector2i(4,8),
	Vector2i(4,7),
	Vector2i(4,6),
	Vector2i(4,5),
	Vector2i(4,4),
	Vector2i(4,3),
	Vector2i(4,2),
	Vector2i(4,1)
]

@onready var player = $Player

# botões
@onready var btn_up = $CanvasLayer/Control/BntUp
@onready var btn_down = $CanvasLayer/Control/BntDown
@onready var btn_left = $CanvasLayer/Control/BntLeft
@onready var btn_right = $CanvasLayer/Control/BntRight
@onready var btn_start = $CanvasLayer/Control/BntStart

func _ready():

	queue_redraw()

	organizar_botoes()

func organizar_botoes():

	# altura da linha dos botões
	var y_botoes = 610

	# linha horizontal
	btn_up.position = Vector2(120, y_botoes)

	btn_left.position = Vector2(250, y_botoes)

	btn_right.position = Vector2(380, y_botoes)

	btn_down.position = Vector2(510, y_botoes)

	# diminuir tamanho dos botões
	btn_up.size = Vector2(90,40)
	btn_left.size = Vector2(90,40)
	btn_right.size = Vector2(90,40)
	btn_down.size = Vector2(90,40)

	# botão iniciar
	btn_start.position = Vector2(820, 620)
	btn_start.size = Vector2(120,50)

func _draw():

	# desenha grid
	for y in range(GRID_SIZE):

		for x in range(GRID_SIZE):

			var pos = Vector2(x,y) * TILE_SIZE + OFFSET

			var cor = Color.BLUE

			# caminho seguro
			if Vector2i(x,y) in caminho:
				cor = Color.GREEN

			# quadrado
			draw_rect(
				Rect2(pos, Vector2(TILE_SIZE,TILE_SIZE)),
				cor
			)

			# borda
			draw_rect(
				Rect2(pos, Vector2(TILE_SIZE,TILE_SIZE)),
				Color.BLACK,
				false,
				2
			)

	# objetivo
	var objetivo = Vector2(4,1) * TILE_SIZE + OFFSET

	draw_rect(
		Rect2(objetivo, Vector2(TILE_SIZE,TILE_SIZE)),
		Color.RED
	)

func _on_bnt_up_pressed():
	player.adicionar_comando("up")

func _on_bnt_down_pressed():
	player.adicionar_comando("down")

func _on_bnt_left_pressed():
	player.adicionar_comando("left")

func _on_bnt_right_pressed():
	player.adicionar_comando("right")

func _on_bnt_start_pressed():
	player.iniciar_execucao()
