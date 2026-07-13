extends "res://Scripts/robot.gd"

# =========================================================
# ROBÔ EXCLUSIVO DA FASE LENDÁRIA
# =========================================================
# Calcula o próprio alinhamento a partir do tamanho real de
# Sprites/Grid/Fase4/img_fase4.png, isolado do robot.gd usado
# pelas fases Fácil/Médio/Difícil — mexer aqui não afeta as outras.
# =========================================================

const CAMINHO_IMAGEM_FASE4 = "res://Sprites/Grid/Fase4/img_fase4.png"
const MENU_HEIGHT_FASE4 = 80

func _ready():
	super._ready()

	var tex = load(CAMINHO_IMAGEM_FASE4)

	if tex != null:
		var centro = Vector2(448, 320 + MENU_HEIGHT_FASE4)
		var origem = centro - tex.get_size() / 2.0

		offset_x = origem.x
		offset_y = origem.y
