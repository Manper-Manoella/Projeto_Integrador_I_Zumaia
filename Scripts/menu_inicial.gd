extends Node2D

# =========================================================
# CONFIGURAÇÕES
# =========================================================

const WINDOW_WIDTH = 1280
const WINDOW_HEIGHT = 720

const BACKGROUND_COLOR = Color("f7f9fc")

# =========================================================
# CORES BOTÕES PRINCIPAIS
# =========================================================

const MAIN_BUTTON_COLOR = Color("025da6")
const MAIN_BUTTON_HOVER_COLOR = Color("025599")
const MAIN_BUTTON_PRESSED_COLOR = Color("01467f")

# =========================================================
# ELEMENTOS INTERFACE
# =========================================================

var slogan
var imagem

# =========================================================
# READY
# =========================================================

func _ready():

	criar_fundo()

	GlobalUI.criar_menu_superior(self)

	criar_conteudo()

# =========================================================
# FUNDO
# =========================================================

func criar_fundo():

	var fundo = ColorRect.new()

	fundo.color = BACKGROUND_COLOR

	fundo.size = Vector2(
		WINDOW_WIDTH,
		WINDOW_HEIGHT
	)

	add_child(fundo)

# =========================================================
# CONTEÚDO PRINCIPAL
# =========================================================

func criar_conteudo():

	# =====================================================
	# SLOGAN
	# =====================================================

	slogan = Label.new()

	slogan.text = "Zumaia:\nAprendendo pensamento\ncomputacional brincando."

	slogan.position = Vector2(
		100,
		220
	)

	slogan.add_theme_color_override(
		"font_color",
		Color("5f9fd9")
	)

	slogan.add_theme_font_size_override(
		"font_size",
		42
	)

	add_child(slogan)

	# =====================================================
	# BOTÃO SABER MAIS
	# =====================================================

	var botao_como_jogar = criar_botao_principal(
		"Saber mais",
		Vector2(120,450),
		Vector2(220,70)
	)

	botao_como_jogar.pressed.connect(
		GlobalUI.ir_para_como_jogar
	)

	add_child(botao_como_jogar)

	# =====================================================
	# BOTÃO JOGAR AGORA
	# =====================================================

	var botao_jogar = criar_botao_principal(
		"Jogar Agora",
		Vector2(380,450),
		Vector2(220,70)
	)

	botao_jogar.pressed.connect(
		GlobalUI.ir_para_jogar
	)

	add_child(botao_jogar)

	# =====================================================
	# IMAGEM
	# =====================================================

	imagem = TextureRect.new()

	imagem.texture = load(
		"res://Sprites/img_tela_inicial.png"
	)

	imagem.position = Vector2(
		720,
		125
	)

	imagem.scale = Vector2(
		0.43,
		0.36
	)

	add_child(imagem)

# =========================================================
# BOTÃO PRINCIPAL
# =========================================================

func criar_botao_principal(
	texto,
	posicao,
	tamanho
):

	var botao = Button.new()

	botao.text = texto

	botao.position = posicao

	botao.size = tamanho

	botao.add_theme_font_size_override(
		"font_size",
		22
	)

	botao.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	# =====================================================
	# NORMAL
	# =====================================================

	var normal = StyleBoxFlat.new()

	normal.bg_color = MAIN_BUTTON_COLOR

	normal.set_corner_radius_all(18)

	# =====================================================
	# HOVER
	# =====================================================

	var hover = StyleBoxFlat.new()

	hover.bg_color = MAIN_BUTTON_HOVER_COLOR

	hover.set_corner_radius_all(18)

	# =====================================================
	# PRESSED
	# =====================================================

	var pressed = StyleBoxFlat.new()

	pressed.bg_color = MAIN_BUTTON_PRESSED_COLOR

	pressed.set_corner_radius_all(18)

	# =====================================================
	# APLICA ESTILOS
	# =====================================================

	botao.add_theme_stylebox_override(
		"normal",
		normal
	)

	botao.add_theme_stylebox_override(
		"hover",
		hover
	)

	botao.add_theme_stylebox_override(
		"pressed",
		pressed
	)

	botao.add_theme_stylebox_override(
		"focus",
		normal
	)

	return botao
