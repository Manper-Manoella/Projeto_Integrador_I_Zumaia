extends Node

# =========================================================
# CONFIGURAÇÕES GERAIS
# =========================================================

const WINDOW_WIDTH = 1280
const WINDOW_HEIGHT = 720

# =========================================================
# CORES GLOBAIS
# =========================================================

const MENU_COLOR = Color("f7f9fc")

const MENU_LINE_COLOR = Color("c9d7ea")
const MENU_LINE_HEIGHT = 2

# =========================================================
# CORES BOTÕES MENU
# =========================================================

const MENU_BUTTON_COLOR = Color("f7f9fc")

const MENU_BUTTON_HOVER_COLOR = Color("025da6")

const MENU_BUTTON_PRESSED_COLOR = Color("014d8b")

# =========================================================
# CORES TEXTO MENU
# =========================================================

const MENU_TEXT_NORMAL = Color("025da6")

const MENU_TEXT_HOVER = Color.WHITE

const MENU_TEXT_PRESSED = Color.WHITE

# =========================================================
# CRIA MENU SUPERIOR
# =========================================================

func criar_menu_superior(tela):

	var menu_bar = ColorRect.new()

	menu_bar.color = MENU_COLOR

	menu_bar.size = Vector2(
		WINDOW_WIDTH,
		80
	)

	tela.add_child(menu_bar)

	# =====================================================
	# LINHA INFERIOR
	# =====================================================

	var linha_menu = ColorRect.new()

	linha_menu.color = MENU_LINE_COLOR

	linha_menu.position = Vector2(
		0,
		80 - MENU_LINE_HEIGHT
	)

	linha_menu.size = Vector2(
		WINDOW_WIDTH,
		MENU_LINE_HEIGHT
	)

	menu_bar.add_child(linha_menu)

	# =====================================================
	# TÍTULO
	# =====================================================

	var titulo = Label.new()

	titulo.text = "Zumaia"

	titulo.position = Vector2(
		40,
		18
	)

	titulo.add_theme_font_size_override(
		"font_size",
		32
	)

	titulo.add_theme_color_override(
		"font_color",
		Color("025da6")
	)

	menu_bar.add_child(titulo)

	# =====================================================
	# BOTÃO INICIO
	# =====================================================

	var btn_inicio = criar_botao_menu(
		"Inicio",
		Vector2(390,20),
		Vector2(140,40)
	)

	btn_inicio.pressed.connect(ir_para_inicio)

	menu_bar.add_child(btn_inicio)

	# =====================================================
	# BOTÃO COMO JOGAR
	# =====================================================

	var btn_como_jogar = criar_botao_menu(
		"Como Jogar",
		Vector2(570,20),
		Vector2(170,40)
	)

	btn_como_jogar.pressed.connect(
		ir_para_como_jogar
	)

	menu_bar.add_child(btn_como_jogar)

	# =====================================================
	# BOTÃO JOGAR
	# =====================================================

	var btn_jogar = criar_botao_menu(
		"Jogar",
		Vector2(780,20),
		Vector2(140,40)
	)

	btn_jogar.pressed.connect(
		ir_para_jogar
	)

	menu_bar.add_child(btn_jogar)

	return menu_bar

# =========================================================
# CRIA BOTÃO MENU
# =========================================================

func criar_botao_menu(
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
		MENU_TEXT_NORMAL
	)

	botao.add_theme_color_override(
		"font_hover_color",
		MENU_TEXT_HOVER
	)

	botao.add_theme_color_override(
		"font_pressed_color",
		MENU_TEXT_PRESSED
	)

	var normal = StyleBoxFlat.new()

	normal.bg_color = MENU_BUTTON_COLOR

	normal.set_corner_radius_all(18)

	var hover = StyleBoxFlat.new()

	hover.bg_color = MENU_BUTTON_HOVER_COLOR

	hover.set_corner_radius_all(18)

	var pressed = StyleBoxFlat.new()

	pressed.bg_color = MENU_BUTTON_PRESSED_COLOR

	pressed.set_corner_radius_all(18)

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

# =========================================================
# NAVEGAÇÃO
# =========================================================

func ir_para_inicio():

	get_tree().change_scene_to_file(
		"res://scenes/menu_inicial.tscn"
	)

func ir_para_como_jogar():

	get_tree().change_scene_to_file(
		"res://scenes/como_jogar.tscn"
	)

func ir_para_jogar():

	get_tree().change_scene_to_file(
		"res://scenes/jogar.tscn"
	)
