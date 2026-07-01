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

	var btn_facil = criar_botao_fase(
		"Jogar",
		Color("83a73c"),
		Color("5f7e21"),
		Vector2(135,455)
	)

	btn_facil.pressed.connect(func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_facil.tscn"
		)
	)

	add_child(btn_facil)

	var btn_medio = criar_botao_fase(
		"Jogar",
		Color("eb9936"),
		Color("c48138"),
		Vector2(535,455)
	)

	btn_medio.pressed.connect(func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_medio.tscn"
		)
	)

	add_child(btn_medio)

	var btn_dificil = criar_botao_fase(
		"Jogar",
		Color("1990a3"),
		Color("117686"),
		Vector2(940,455)
	)

	btn_dificil.pressed.connect(func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_dificil.tscn"
		)
	)

	add_child(btn_dificil)

# =========================================================
# BOTÃO DAS FASES
# =========================================================

func criar_botao_fase(
	texto,
	cor,
	cor_borda,
	posicao
):

	var botao = Button.new()

	botao.text = texto

	botao.position = posicao

	botao.size = Vector2(
		210,
		65
	)

	botao.add_theme_font_size_override(
		"font_size",
		24
	)

	botao.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	# =====================================================
	# NORMAL
	# =====================================================

	var normal = StyleBoxFlat.new()

	normal.bg_color = cor

	normal.border_color = cor_borda

	normal.set_border_width_all(4)

	normal.corner_radius_top_left = 20
	normal.corner_radius_top_right = 20
	normal.corner_radius_bottom_left = 20
	normal.corner_radius_bottom_right = 20

	# =====================================================
	# HOVER
	# =====================================================

	var hover = StyleBoxFlat.new()

	hover.bg_color = cor.lightened(0.08)

	hover.border_color = cor_borda

	hover.set_border_width_all(4)

	hover.corner_radius_top_left = 20
	hover.corner_radius_top_right = 20
	hover.corner_radius_bottom_left = 20
	hover.corner_radius_bottom_right = 20

	# =====================================================
	# PRESSED
	# =====================================================

	var pressed = StyleBoxFlat.new()

	pressed.bg_color = cor.darkened(0.15)

	pressed.border_color = cor_borda.darkened(0.2)

	pressed.set_border_width_all(4)

	pressed.corner_radius_top_left = 20
	pressed.corner_radius_top_right = 20
	pressed.corner_radius_bottom_left = 20
	pressed.corner_radius_bottom_right = 20

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
