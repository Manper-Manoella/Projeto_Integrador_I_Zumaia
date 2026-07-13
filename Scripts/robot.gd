extends Sprite2D

# =========================================================
# GRID
# =========================================================

var grid

# =========================================================
# CONFIGURAÇÕES VISUAIS
# =========================================================

const TILE_SIZE = 60

# offset_x/offset_y = canto superior-esquerdo do tabuleiro (não o centro
# do robô). +4 no ajuste vertical compensa a margem interna assimétrica
# do sprite (1px em cima, 9px embaixo dentro do canvas 60x60).
var offset_x = 88
var offset_y = 160
const AJUSTE_VERTICAL_SPRITE = 4

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

	centered = true

	z_index = 10

# =========================================================
# DEFINIR GRID
# =========================================================

func definir_grid(grid_manager):

	grid = grid_manager

	atualizar_posicao()

# =========================================================
# DEFINIR ORIGEM DO GRID (calculada a partir da imagem real)
# =========================================================

func definir_origem(origem_grid: Vector2):

	offset_x = origem_grid.x
	offset_y = origem_grid.y

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

		offset_x +
		grid.robo_pos.x * TILE_SIZE +
		TILE_SIZE / 2.0,

		offset_y +
		grid.robo_pos.y * TILE_SIZE +
		TILE_SIZE / 2.0 +
		AJUSTE_VERTICAL_SPRITE

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
