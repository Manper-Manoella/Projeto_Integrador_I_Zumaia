extends Sprite2D

# =========================================================
# GRID
# =========================================================

var grid

# =========================================================
# CONFIGURAÇÕES VISUAIS
# =========================================================

const TILE_SIZE = 60

const GRID_OFFSET_X = 88
const GRID_OFFSET_Y = 160

# =========================================================
# DIREÇÃO
# =========================================================

var ultima_direcao = Vector2i(1, 0)

# =========================================================
# READY
# =========================================================

func _ready():

	texture = preload(
		"res://Sprites/Grid/img_robo.png"
	)

	centered = false

	z_index = 10

# =========================================================
# DEFINIR GRID
# =========================================================

func definir_grid(grid_manager):

	grid = grid_manager

	atualizar_posicao()

# =========================================================
# PROCESS
# =========================================================

func _process(_delta):

	if grid == null:
		return

	atualizar_posicao()

# =========================================================
# POSIÇÃO VISUAL
# =========================================================

func atualizar_posicao():

	position = Vector2(

		GRID_OFFSET_X +
		grid.robo_pos.x * TILE_SIZE,

		GRID_OFFSET_Y +
		grid.robo_pos.y * TILE_SIZE

	)

# =========================================================
# OLHAR PARA ESQUERDA
# =========================================================

func olhar_esquerda():

	ultima_direcao = Vector2i(-1, 0)

	flip_h = true

# =========================================================
# OLHAR PARA DIREITA
# =========================================================

func olhar_direita():

	ultima_direcao = Vector2i(1, 0)

	flip_h = false

# =========================================================
# ATUALIZAR DIREÇÃO
# =========================================================

func atualizar_direcao(dir):

	if dir.x > 0:
		olhar_direita()

	elif dir.x < 0:
		olhar_esquerda()
