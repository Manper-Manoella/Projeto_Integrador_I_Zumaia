extends Node

# =========================================================
# SINAIS
# =========================================================

signal erro_algoritmo(tipo_bloco)

signal fase_concluida

signal limite_mapa

# =========================================================
# CONFIGURAÇÕES DO GRID
# =========================================================

const GRID_WIDTH = 12
const GRID_HEIGHT = 8

# =========================================================
# TIPOS DE BLOCO
# =========================================================

enum TipoBloco {
	LIVRE,
	AGUA,
	OBSTACULO,
	MOVEDICA,
	ESPINHO,
	LAVA,
	CHEGADA
}

# =========================================================
# DADOS DO MAPA
# =========================================================

var mapa = []

# =========================================================
# POSIÇÃO DO ROBÔ
# =========================================================

var robo_pos = Vector2i(0, 0)

# =========================================================
# INICIALIZAÇÃO
# =========================================================

func setup():

	criar_mapa_vazio()

# =========================================================
# MAPA VAZIO
# =========================================================

func criar_mapa_vazio():

	mapa.clear()

	for y in range(GRID_HEIGHT):

		var linha = []

		for x in range(GRID_WIDTH):

			linha.append(
				TipoBloco.LIVRE
			)

		mapa.append(linha)

# =========================================================
# CARREGAR MAPA
# =========================================================

func carregar_mapa(novo_mapa):

	mapa = novo_mapa

# =========================================================
# PEGAR TIPO DE BLOCO
# =========================================================

func get_tipo_bloco(x, y):

	if x < 0 or x >= GRID_WIDTH:
		return null

	if y < 0 or y >= GRID_HEIGHT:
		return null

	return mapa[y][x]

# =========================================================
# DEFINIR POSIÇÃO DO ROBÔ
# =========================================================

func definir_posicao_robo(x, y):

	if x < 0 or x >= GRID_WIDTH:
		return

	if y < 0 or y >= GRID_HEIGHT:
		return

	robo_pos = Vector2i(x, y)

# =========================================================
# REINICIAR ROBÔ
# =========================================================

func reiniciar_robo():

	robo_pos = Vector2i(0, 0)

# =========================================================
# MOVIMENTO
# =========================================================

func mover_robo(dir):

	var nova_pos = robo_pos + dir

	if nova_pos.x < 0 or nova_pos.x >= GRID_WIDTH:
		limite_mapa.emit()
		return false

	if nova_pos.y < 0 or nova_pos.y >= GRID_HEIGHT:
		limite_mapa.emit()
		return false

	var tipo = mapa[
		int(nova_pos.y)
	][
		int(nova_pos.x)
	]

	if tipo == TipoBloco.OBSTACULO:

		erro_algoritmo.emit(
			TipoBloco.OBSTACULO
		)

		return false

	if tipo == TipoBloco.AGUA:

		robo_pos = nova_pos

		erro_algoritmo.emit(
			TipoBloco.AGUA
		)

		return false

	if tipo == TipoBloco.LAVA:

		robo_pos = nova_pos

		erro_algoritmo.emit(
			TipoBloco.LAVA
		)

		return false

	if tipo == TipoBloco.ESPINHO:

		erro_algoritmo.emit(
			TipoBloco.ESPINHO
		)

		return false

	if tipo == TipoBloco.MOVEDICA:

		erro_algoritmo.emit(
			TipoBloco.MOVEDICA
		)

		return false

	if tipo == TipoBloco.CHEGADA:

		robo_pos = nova_pos

		fase_concluida.emit()

		return false

	robo_pos = nova_pos

	return true
