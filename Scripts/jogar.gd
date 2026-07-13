extends Node2D

const BACKGROUND_COLOR = Color("f7f9fc")

# =========================================================
# READY
# =========================================================

func _ready():

	criar_fundo()

	GlobalUI.criar_menu_superior(self)

	criar_botoes_fases()

# =========================================================
# FUNDO
# =========================================================

func criar_fundo():

	var background = ColorRect.new()

	background.color = BACKGROUND_COLOR

	background.position = Vector2.ZERO

	background.size = Vector2(
		GlobalUI.WINDOW_WIDTH,
		GlobalUI.WINDOW_HEIGHT
	)

	add_child(background)

	var fundo = TextureRect.new()

	fundo.texture = load(
		"res://Sprites/img_tela_jogar_fundo.png"
	)

	fundo.position = Vector2.ZERO

	fundo.size = Vector2(
		GlobalUI.WINDOW_WIDTH,
		GlobalUI.WINDOW_HEIGHT
	)

	fundo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE

	fundo.stretch_mode = TextureRect.STRETCH_SCALE

	add_child(fundo)

# =========================================================
# BOTÕES DAS FASES
# =========================================================

func criar_botoes_fases():

	# O texto "Jogar" já está desenhado dentro de cada card, na imagem de
	# fundo (y=416 a 456, 113px de largura, centralizado). A área clicável
	# é invisível e cobre exatamente esse retângulo, sem desenhar nada por
	# cima — assim não duplica visualmente o "Jogar" da arte.

	criar_area_clicavel(
		Vector2(128, 416),
		Vector2(113, 40),
		"res://scenes/nivel_facil.tscn"
	)

	criar_area_clicavel(
		Vector2(430, 416),
		Vector2(113, 40),
		"res://scenes/nivel_medio.tscn"
	)

	criar_area_clicavel(
		Vector2(731, 416),
		Vector2(113, 40),
		"res://scenes/nivel_dificil.tscn"
	)

	criar_area_clicavel(
		Vector2(1020, 416),
		Vector2(113, 40),
		"res://scenes/nivel_lava.tscn"
	)

# =========================================================
# ÁREA CLICÁVEL INVISÍVEL (sobre o "Jogar" já desenhado na arte)
# =========================================================

func criar_area_clicavel(
	posicao,
	tamanho,
	cena_destino
):
	var area = Button.new()

	area.position = posicao
	area.size = tamanho
	area.flat = true
	area.modulate = Color(1, 1, 1, 0)
	area.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	area.pressed.connect(func():
		get_tree().change_scene_to_file(cena_destino)
	)

	add_child(area)
