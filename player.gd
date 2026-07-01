extends CharacterBody2D

const TILE_SIZE = 64
const MOVE_SPEED = 200.0

# posição onde começa o tabuleiro
const OFFSET = Vector2(80,60)

# centro do tile
const TILE_CENTER = Vector2(32,32)

var comandos = []
var executando = false
var moving = false

var target_position = Vector2.ZERO

# mapa
# 1 = caminho
# 0 = água
var mapa = [
	[0,0,0,0,0,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0],
	[0,0,0,0,1,0,0,0,0]
]

# posição do player no grid
var grid_position = Vector2i(4,8)

var current_command = 0

func _ready():

	atualizar_posicao_visual()

func _physics_process(delta):

	if moving:

		position = position.move_toward(
			target_position,
			MOVE_SPEED * delta
		)

		if position.distance_to(target_position) < 1:

			position = target_position

			moving = false

			verificar_agua()

			executar_proximo()

func atualizar_posicao_visual():

	position = OFFSET + (
		Vector2(grid_position.x, grid_position.y) * TILE_SIZE
	) + TILE_CENTER

	target_position = position

func adicionar_comando(comando):

	if executando:
		return

	comandos.append(comando)

	print(comandos)

func iniciar_execucao():

	if comandos.size() == 0:
		return

	executando = true

	current_command = 0

	executar_proximo()

func executar_proximo():

	if current_command >= comandos.size():

		executando = false

		print("Fim da execução")

		return

	var comando = comandos[current_command]

	current_command += 1

	match comando:

		"up":
			grid_position.y -= 1

		"down":
			grid_position.y += 1

		"left":
			grid_position.x -= 1

		"right":
			grid_position.x += 1

	target_position = OFFSET + (
		Vector2(grid_position.x, grid_position.y) * TILE_SIZE
	) + TILE_CENTER

	moving = true

func verificar_agua():

	# saiu do mapa
	if (
		grid_position.x < 0
		or grid_position.x >= 9
		or grid_position.y < 0
		or grid_position.y >= 9
	):

		cair_na_agua()

		return

	# caiu na água
	if mapa[grid_position.y][grid_position.x] == 0:

		cair_na_agua()

func cair_na_agua():

	print("Caiu na água!")

	grid_position = Vector2i(4,8)

	atualizar_posicao_visual()

	comandos.clear()

	executando = false
