extends Node2D
var scroll_algoritmo
var conteudo_algoritmo
var popup_fundo = null
var popup_imagem = null
const GridManager = preload(
	"res://Scripts/grid_manager.gd"
)
const Robot = preload(
	"res://Scripts/robot.gd"
)
var grid : GridManager
var robo : Robot
var btn_avancar
var btn_esquerda
var btn_direita
var btn_voltar
var algoritmo = []
var area_algoritmo
var imagens_algoritmo = []
var numeros_algoritmo = []
var fundo_grid
var camada_popup

# =========================================================
# ÁREA PRINCIPAL
# =========================================================
const MENU_HEIGHT = 80
const GRID_AREA_WIDTH = 896
const ALGORITHM_AREA_WIDTH = 384
const CONTENT_HEIGHT = 640
# =========================================================
# CORES
# =========================================================
const GRID_BACKGROUND = Color("ffffff")
const ALGORITHM_BACKGROUND = Color("eef4fb")
# =========================================================
# READY
# =========================================================
func _ready():
	criar_layout()
	camada_popup = CanvasLayer.new()
	camada_popup.layer = 1
	add_child(camada_popup)
	grid = GridManager.new()
	add_child(grid)
	grid.setup()
	grid.erro_algoritmo.connect(
		_ao_erro_algoritmo
	)
	
	grid.fase_concluida.connect(
		_ao_fase_concluida
	)

	grid.limite_mapa.connect(
		_ao_limite_mapa
	)

	robo = obter_robot_script().new()
	add_child(robo)
	robo.definir_grid(grid)
	configurar_fase()

# =========================================================
# CONFIGURAR FASE
# =========================================================
func configurar_fase():
	pass

# =========================================================
# SCRIPT DO ROBÔ (sobrescrevível por fase)
# =========================================================
func obter_robot_script():
	return Robot

# =========================================================
# NAVEGAÇÃO VIA TECLADO
# =========================================================
func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		_ao_clicar_avancar()
	elif event.is_action_pressed("ui_down"):
		_ao_clicar_voltar()
	elif event.is_action_pressed("ui_left"):
		_ao_clicar_esquerda()
	elif event.is_action_pressed("ui_right"):
		_ao_clicar_direita()

# =========================================================
# LAYOUT COMPLETO
# =========================================================
func criar_layout():
	criar_menu_superior_niveis()
	criar_area_grid()
	criar_area_algoritmo()
	criar_area_comandos()

# =========================================================
# MENU SUPERIOR NOVO (NÍVEIS)
# =========================================================
func criar_menu_superior_niveis():
	var menu_bar = ColorRect.new()
	menu_bar.color = Color("f7f9fc")
	menu_bar.size = Vector2(1280, MENU_HEIGHT)
	add_child(menu_bar)
	var linha = ColorRect.new()
	linha.color = Color("c9d7ea")
	linha.position = Vector2(0, MENU_HEIGHT - 2)
	linha.size = Vector2(1280, 2)
	menu_bar.add_child(linha)
	var titulo = Label.new()
	titulo.text = "Zumaia"
	titulo.position = Vector2(40, 18)
	titulo.add_theme_font_size_override("font_size", 32)
	titulo.add_theme_color_override("font_color", Color("025da6"))
	menu_bar.add_child(titulo)
	var btn_facil = criar_botao_nivel(
		"Fácil",
		Vector2(350, 20),
		Color("83a73c"),
		Color("5f7e21"),
		func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_facil.tscn"
		)
	)
	menu_bar.add_child(btn_facil)
	var btn_medio = criar_botao_nivel(
		"Médio",
		Vector2(470, 20),
		Color("eb9936"),
		Color("c48138"),
		func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_medio.tscn"
		)
	)
	menu_bar.add_child(btn_medio)
	var btn_dificil = criar_botao_nivel(
		"Difícil",
		Vector2(600, 20),
		Color("1990a3"),
		Color("117686"),
		func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_dificil.tscn"
		)
	)
	menu_bar.add_child(btn_dificil)
	var btn_lendaria = criar_botao_nivel(
		"Lendária",
		Vector2(730, 20),
		Color("d84315"),
		Color("a3330f"),
		func():
		get_tree().change_scene_to_file(
			"res://scenes/nivel_lava.tscn"
		)
	)
	menu_bar.add_child(btn_lendaria)
	var btn_sair = criar_botao_nivel(
		"Sair",
		Vector2(1120, 20),
		Color("f7f9fc"),
		Color("025da6"),
		func():
			get_tree().change_scene_to_file("res://scenes/jogar.tscn")
	)
	menu_bar.add_child(btn_sair)
# =========================================================
# BOTÃO NÍVEL
# =========================================================
func criar_botao_nivel(texto, posicao, cor, cor_hover, acao):
	var botao = Button.new()
	botao.text = texto
	botao.position = posicao
	botao.size = Vector2(110, 40)
	botao.add_theme_font_size_override("font_size", 20)
	botao.add_theme_color_override("font_color", Color("025da6"))
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color("f7f9fc")
	normal.set_corner_radius_all(14)
	var hover = StyleBoxFlat.new()
	hover.bg_color = cor_hover
	hover.set_corner_radius_all(14)
	var pressed = StyleBoxFlat.new()
	pressed.bg_color = cor_hover.darkened(0.2)
	pressed.set_corner_radius_all(14)
	botao.add_theme_stylebox_override("normal", normal)
	botao.add_theme_stylebox_override("hover", hover)
	botao.add_theme_stylebox_override("pressed", pressed)
	botao.add_theme_stylebox_override("focus", normal)
	botao.pressed.connect(acao)
	return botao
# =========================================================
# GRID
# =========================================================

func criar_area_grid():

	fundo_grid = TextureRect.new()

	fundo_grid.position = Vector2(
		0,
		MENU_HEIGHT
	)

	fundo_grid.size = Vector2(
		GRID_AREA_WIDTH,
		CONTENT_HEIGHT
	)

	fundo_grid.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	fundo_grid.stretch_mode = TextureRect.STRETCH_SCALE

	add_child(fundo_grid)
	
	
#======================================
# ALTERAR FUNDO DO GRID
#======================================

func definir_fundo_grid(caminho):

	fundo_grid.texture = load(caminho)
	
	
# =========================================================
# ALGORITMO
# =========================================================
func criar_area_algoritmo():
	var fundo_algoritmo = ColorRect.new()
	fundo_algoritmo.color = ALGORITHM_BACKGROUND
	fundo_algoritmo.position = Vector2(
		GRID_AREA_WIDTH,
		MENU_HEIGHT
	)
	fundo_algoritmo.size = Vector2(
		ALGORITHM_AREA_WIDTH,
		CONTENT_HEIGHT
	)
	add_child(fundo_algoritmo)
	var titulo = Label.new()
	titulo.text = "ALGORITMO"
	titulo.position = Vector2(1020, 110)
	titulo.add_theme_font_size_override(
		"font_size",
		28
	)
	titulo.add_theme_color_override(
		"font_color",
		Color("025da6")
	)
	add_child(titulo)
	scroll_algoritmo = ScrollContainer.new()
	scroll_algoritmo.position = Vector2(
		GRID_AREA_WIDTH,
		150
	)
	scroll_algoritmo.size = Vector2(
		ALGORITHM_AREA_WIDTH,
		470
	)
	add_child(scroll_algoritmo)
	conteudo_algoritmo = Control.new()
	conteudo_algoritmo.custom_minimum_size = Vector2(
		ALGORITHM_AREA_WIDTH,
		500
	)
	scroll_algoritmo.add_child(
		conteudo_algoritmo
	)
	area_algoritmo = Node2D.new()
	conteudo_algoritmo.add_child(
		area_algoritmo
	)
# =========================================================
# COMANDOS (ATUALIZADO)
# =========================================================
func criar_area_comandos():
	var largura_botao = 90
	var altura_botao = 45
	var y = 650
	# =====================================================
	# BOTÕES DE MOVIMENTO (TRANSPARENTES, COM IMAGEM DENTRO)
	# A imagem é filha do botão: fica atrás do texto do botão,
	# mas como o botão é transparente, a imagem aparece por
	# cima de todo o resto do cenário (menu, grid, algoritmo).
	# A imagem mantém a proporção original (95x95) e é
	# centralizada dentro da área do botão.
	# =====================================================
	btn_avancar = criar_botao_comando("", Vector2(240,y), Vector2(largura_botao,altura_botao))
	btn_avancar.flat = true
	add_child(btn_avancar)
	btn_avancar.add_child(
		criar_imagem_botao(
			"res://Sprites/Botoes/img_botao_subir.png",
			Vector2(largura_botao, altura_botao)
		)
	)
	btn_esquerda = criar_botao_comando("", Vector2(340,y), Vector2(largura_botao,altura_botao))
	btn_esquerda.flat = true
	add_child(btn_esquerda)
	btn_esquerda.add_child(
		criar_imagem_botao(
			"res://Sprites/Botoes/img_botao_esquerda.png",
			Vector2(largura_botao, altura_botao)
		)
	)
	btn_direita = criar_botao_comando("", Vector2(440,y), Vector2(largura_botao,altura_botao))
	btn_direita.flat = true
	add_child(btn_direita)
	btn_direita.add_child(
		criar_imagem_botao(
			"res://Sprites/Botoes/img_botao_direita.png",
			Vector2(largura_botao, altura_botao)
		)
	)
	btn_voltar = criar_botao_comando("", Vector2(540,y), Vector2(largura_botao,altura_botao))
	btn_voltar.flat = true
	add_child(btn_voltar)
	btn_voltar.add_child(
		criar_imagem_botao(
			"res://Sprites/Botoes/img_botao_descer.png",
			Vector2(largura_botao, altura_botao)
		)
	)
	# Remove qualquer estilo de fundo para garantir transparência total
	for b in [btn_avancar, btn_esquerda, btn_direita, btn_voltar]:
		var vazio = StyleBoxEmpty.new()
		b.add_theme_stylebox_override("normal", vazio)
		b.add_theme_stylebox_override("hover", vazio)
		b.add_theme_stylebox_override("pressed", vazio)
		b.add_theme_stylebox_override("focus", vazio)
	# =====================================================
	# CONTROLES DO ALGORITMO
	# =====================================================
	# Lixeira (apaga tudo)
	var btn_excluir = criar_botao_comando(
		"🗑",
		Vector2(907, y),
		Vector2(60, 45)
	)
	btn_excluir.add_theme_stylebox_override(
		"normal",
		_botao_vermelho()
	)
	btn_excluir.add_theme_stylebox_override(
		"hover",
		_botao_vermelho(true)
	)
	btn_excluir.add_theme_stylebox_override(
		"pressed",
		_botao_vermelho(false, true)
	)
	btn_excluir.pressed.connect(
		_limpar_algoritmo
	)
	add_child(btn_excluir)
	# Apagar último comando
	var btn_apagar_comando = criar_botao_comando(
		"Apagar Comando",
		Vector2(977, y),
		Vector2(180, 45)
	)
	btn_apagar_comando.add_theme_stylebox_override(
	"normal",
	_botao_amarelo()
)
	btn_apagar_comando.add_theme_stylebox_override(
		"hover",
		_botao_amarelo(true)
	)
	btn_apagar_comando.add_theme_stylebox_override(
		"pressed",
		_botao_amarelo(false, true)
	)
	btn_apagar_comando.pressed.connect(
		_excluir_ultimo_comando
	)
	add_child(btn_apagar_comando)
	# Executar
	var btn_iniciar = criar_botao_comando(
		"Executar",
		Vector2(1167, y),
		Vector2(100, 45)
	)
	btn_iniciar.pressed.connect(
		_executar_algoritmo
	)
	add_child(btn_iniciar)
	
	btn_avancar.pressed.connect(_ao_clicar_avancar)
	btn_esquerda.pressed.connect(_ao_clicar_esquerda)
	btn_direita.pressed.connect(_ao_clicar_direita)
	btn_voltar.pressed.connect(_ao_clicar_voltar)
	
# =========================================================
# ESTILOS NOVOS
# =========================================================
func _botao_vermelho(hover=false, pressed=false):
	var c = Color("c0392b")
	if hover:
		c = Color("e74c3c")
	if pressed:
		c = Color("96281b")
	var s = StyleBoxFlat.new()
	s.bg_color = c
	s.set_corner_radius_all(12)
	return s
func _botao_azul(hover=false, pressed=false):
	var c = Color("025da6")
	if hover:
		c = Color("0275d8")
	if pressed:
		c = Color("01467f")
	var s = StyleBoxFlat.new()
	s.bg_color = c
	s.set_corner_radius_all(12)
	return s
func _botao_amarelo(hover=false, pressed=false):
	var c = Color("d49b0fff")
	if hover:
		c = Color("d4a017")
	if pressed:
		c = Color("a87b0cff")
	var s = StyleBoxFlat.new()
	s.bg_color = c
	s.set_corner_radius_all(12)
	return s
	
# =========================================================
# BOTÃO COMANDO
# =========================================================
func criar_botao_comando(texto, posicao, tamanho):
	var botao = Button.new()
	botao.text = texto
	botao.position = posicao
	botao.size = tamanho
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color("025da6")
	normal.set_corner_radius_all(12)
	var hover = StyleBoxFlat.new()
	hover.bg_color = Color("0275d8")
	hover.set_corner_radius_all(12)
	var pressed = StyleBoxFlat.new()
	pressed.bg_color = Color("01467f")
	pressed.set_corner_radius_all(12)
	botao.add_theme_stylebox_override("normal", normal)
	botao.add_theme_stylebox_override("hover", hover)
	botao.add_theme_stylebox_override("pressed", pressed)
	botao.add_theme_stylebox_override("focus", normal)
	botao.add_theme_color_override("font_color", Color.WHITE)
	return botao
#======================================
# IMAGEM DE FUNDO DO BOTÃO
# (fica atrás do botão; mantém a
# proporção original da textura e é
# centralizada dentro da área do botão)
#======================================
func criar_imagem_botao(caminho, tamanho):
	var imagem = Sprite2D.new()
	var tex = load(caminho)
	if tex == null:
		push_error("Não foi possível carregar a imagem: " + caminho)
		return imagem
	imagem.texture = tex
	imagem.centered = false
	var tex_size = tex.get_size()
	# Escala uniforme (mesmo fator em X e Y) baseada no menor
	# lado disponível, para nunca esticar/deformar a imagem.
	# Ex: textura 95x95, área 90x45 -> fator = min(90/95, 45/95) = 45/95
	# Resultado final: 45x45 (proporcional), centralizado na área 90x45.
	var fator = min(
		tamanho.x / tex_size.x,
		tamanho.y / tex_size.y
	)
	imagem.scale = Vector2(fator, fator)
	var tamanho_final = tex_size * fator
	imagem.position = (tamanho - tamanho_final) / 2.0
	return imagem
#======================================
# CRIAR A IMAGEM DAS FASES
#======================================
func criar_imagem_fase(caminho):
	var imagem = Sprite2D.new()
	imagem.texture = load(caminho)
	imagem.position = Vector2(
		448,
		320 + MENU_HEIGHT
	)
	add_child(imagem)
#======================================
# MOVIMENTO DOS BOTÕES
#======================================
func _ao_clicar_avancar():
	algoritmo.append(
		Vector2i(0, -1)
	)
	atualizar_area_algoritmo()
func _ao_clicar_voltar():
	algoritmo.append(
		Vector2i(0, 1)
	)
	atualizar_area_algoritmo()
func _ao_clicar_esquerda():
	algoritmo.append(
		Vector2i(-1, 0)
	)
	atualizar_area_algoritmo()
func _ao_clicar_direita():
	algoritmo.append(
		Vector2i(1, 0)
	)
	atualizar_area_algoritmo()
#======================================
# EXECUTAR ALGORITMO
#======================================
func _executar_algoritmo():
	grid.reiniciar_robo()
	robo.atualizar_direcao(
		Vector2i(1, 0)
	)
	await get_tree().create_timer(
		0.2
	).timeout
	for comando in algoritmo:
		if comando.x > 0:
			robo.atualizar_direcao(
				Vector2i(1, 0)
			)
		elif comando.x < 0:
			robo.atualizar_direcao(
				Vector2i(-1, 0)
			)
		var resultado = grid.mover_robo(
			comando
		)
		if resultado == false:
			return
		await get_tree().create_timer(
			0.5
		).timeout
#======================================
# APAGAR ÚLTIMO COMANDO
#======================================
func _excluir_ultimo_comando():
	if algoritmo.size() > 0:
		algoritmo.pop_back()
		
	atualizar_area_algoritmo()
	
func _limpar_algoritmo():
	algoritmo.clear()
	atualizar_area_algoritmo()
	
#=================================================
func atualizar_area_algoritmo():
	for img in imagens_algoritmo:
		img.queue_free()
	imagens_algoritmo.clear()
	for filho in area_algoritmo.get_children():
		filho.queue_free()
	var escala = 0.6
	var altura_final = 124 * escala
	var espacamento = 10
	conteudo_algoritmo.custom_minimum_size = Vector2(
		ALGORITHM_AREA_WIDTH,
		max(
			500,
			algoritmo.size() * (altura_final + espacamento) + 100
		)
	)
	var x_imagem = ALGORITHM_AREA_WIDTH / 2 + 20
	var y_inicial = 50
	for i in range(algoritmo.size()):
		var comando = algoritmo[i]
		# =====================================
		# NÚMERO
		# =====================================
		var numero = Label.new()
		numero.text = str(i + 1) + "."
		numero.position = Vector2(
			40,
			y_inicial + i * (altura_final + espacamento) - 15
		)
		numero.add_theme_font_size_override(
			"font_size",
			22
		)
		numero.add_theme_color_override(
			"font_color",
			Color("025da6")
		)
		area_algoritmo.add_child(numero)
		# =====================================
		# IMAGEM
		# =====================================
		var sprite = Sprite2D.new()
		sprite.centered = true
		if comando == Vector2i(1, 0):
			sprite.texture = load(
				"res://Sprites/Algoritimo/img_direita.png"
			)
		elif comando == Vector2i(-1, 0):
			sprite.texture = load(
				"res://Sprites/Algoritimo/img_esquerda.png"
			)
		elif comando == Vector2i(0, -1):
			sprite.texture = load(
				"res://Sprites/Algoritimo/img_subir.png"
			)
		elif comando == Vector2i(0, 1):
			sprite.texture = load(
				"res://Sprites/Algoritimo/img_descer.png"
			)
		sprite.scale = Vector2(
			escala,
			escala
		)
		sprite.position = Vector2(
			x_imagem,
			y_inicial + i * (altura_final + espacamento)
		)
		area_algoritmo.add_child(sprite)
		imagens_algoritmo.append(sprite)
#==========================================
# Pop ups de erro
#==========================================
func mostrar_popup(caminho_imagem):
	if popup_fundo != null:
		popup_fundo.queue_free()
	popup_fundo = ColorRect.new()
	popup_fundo.color = Color(
		0,
		0,
		0,
		0.65
	)
	popup_fundo.position = Vector2.ZERO
	popup_fundo.size = Vector2(1280, 720)
	camada_popup.add_child(popup_fundo)
	popup_imagem = Sprite2D.new()
	popup_imagem.texture = load(
		caminho_imagem
	)
	popup_imagem.centered = true
	popup_imagem.scale = Vector2(
		0.7,
		0.7
	)
	popup_imagem.position = Vector2(
		640,
		350
	)
	popup_fundo.add_child(
		popup_imagem
	)

	var btn_desistir = criar_botao_comando(
		"",
		Vector2(350, 560),
		Vector2(250, 50)
	)
	btn_desistir.flat = true
	var vazio_desistir = StyleBoxEmpty.new()
	btn_desistir.add_theme_stylebox_override("normal", vazio_desistir)
	btn_desistir.add_theme_stylebox_override("hover", vazio_desistir)
	btn_desistir.add_theme_stylebox_override("pressed", vazio_desistir)
	btn_desistir.add_theme_stylebox_override("focus", vazio_desistir)
	btn_desistir.pressed.connect(
		func():
			get_tree().change_scene_to_file(
				"res://scenes/jogar.tscn"
			)
	)
	popup_fundo.add_child(
		btn_desistir
	)
	var btn_tentar = criar_botao_comando(
		"",
		Vector2(640, 560),
		Vector2(280, 50)
	)
	btn_tentar.flat = true
	var vazio_tentar = StyleBoxEmpty.new()
	btn_tentar.add_theme_stylebox_override("normal", vazio_tentar)
	btn_tentar.add_theme_stylebox_override("hover", vazio_tentar)
	btn_tentar.add_theme_stylebox_override("pressed", vazio_tentar)
	btn_tentar.add_theme_stylebox_override("focus", vazio_tentar)
	btn_tentar.pressed.connect(
		_fechar_popup
	)
	popup_fundo.add_child(
		btn_tentar
	)
	
func _fechar_popup():
	if popup_fundo != null:
		popup_fundo.queue_free()
		popup_fundo = null
#==========================================
# Popup de texto (sem imagem ilustrativa)
#==========================================
func mostrar_popup_texto(mensagem):
	if popup_fundo != null:
		popup_fundo.queue_free()
	popup_fundo = ColorRect.new()
	popup_fundo.color = Color(0, 0, 0, 0.65)
	popup_fundo.position = Vector2.ZERO
	popup_fundo.size = Vector2(1280, 720)
	camada_popup.add_child(popup_fundo)

	var caixa = Panel.new()
	caixa.size = Vector2(560, 320)
	caixa.position = Vector2(360, 180)

	var estilo_caixa = StyleBoxFlat.new()
	estilo_caixa.bg_color = Color("d6e9f5")
	estilo_caixa.border_color = Color("2f6fa3")
	estilo_caixa.set_border_width_all(4)
	estilo_caixa.corner_radius_top_left = 24
	estilo_caixa.corner_radius_top_right = 24
	estilo_caixa.corner_radius_bottom_left = 24
	estilo_caixa.corner_radius_bottom_right = 24
	caixa.add_theme_stylebox_override("panel", estilo_caixa)

	popup_fundo.add_child(caixa)

	var titulo = Label.new()
	titulo.text = "ATENÇÃO"
	titulo.position = Vector2(0, 30)
	titulo.size = Vector2(560, 40)
	titulo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	titulo.add_theme_font_size_override("font_size", 26)
	titulo.add_theme_color_override("font_color", Color("c0392b"))
	caixa.add_child(titulo)

	var texto = Label.new()
	texto.text = mensagem
	texto.position = Vector2(40, 100)
	texto.size = Vector2(480, 110)
	texto.autowrap_mode = TextServer.AUTOWRAP_WORD
	texto.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	texto.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	texto.add_theme_font_size_override("font_size", 22)
	texto.add_theme_color_override("font_color", Color("1c3d5a"))
	caixa.add_child(texto)

	var btn_ok = criar_botao_comando(
		"Entendi",
		Vector2(130, 245),
		Vector2(300, 55)
	)
	btn_ok.pressed.connect(_fechar_popup)
	caixa.add_child(btn_ok)
func _ao_limite_mapa():
	mostrar_popup_texto("Você tentou entrar numa área proibida")
func _ao_erro_algoritmo(tipo_bloco):
	if tipo_bloco == GridManager.TipoBloco.AGUA:
		mostrar_popup(
			"res://Sprites/Perdeu/img_popup_caiu_agua.png"
		)
	elif tipo_bloco == GridManager.TipoBloco.OBSTACULO:
		mostrar_popup(
			"res://Sprites/Perdeu/img_popup_area_bloqueada.png"
		)
	elif tipo_bloco == GridManager.TipoBloco.MOVEDICA:
		mostrar_popup(
			"res://Sprites/Perdeu/img_popup_areia_movedica.png"
		)
	elif tipo_bloco == GridManager.TipoBloco.ESPINHO:
		mostrar_popup(
			"res://Sprites/Perdeu/img_popup_cacto.png"
		)
	elif tipo_bloco == GridManager.TipoBloco.LAVA:
		mostrar_popup(
			"res://Sprites/Perdeu/img_popup_lava.png"
		)
func _ao_fase_concluida():
	mostrar_popup_vitoria()


#=================================================
# CONFIGURAÇÃO DA PONTUAÇÃO
# (cada fase sobrescreve esta função)
#=================================================

func obter_pontuacao():

	return {
		"tres": 0,
		"duas": 0,
		"img3": "",
		"img2": "",
		"img1": "",
		"proxima": ""
	}

func mostrar_popup_vitoria():

	var dados = obter_pontuacao()
	var passos = algoritmo.size()
	var imagem = ""

	if dados.has("quatro") and passos <= dados.quatro:
		imagem = dados.img4
	elif passos <= dados.tres:
		imagem = dados.img3
	elif passos <= dados.duas:
		imagem = dados.img2
	else:
		imagem = dados.img1

	if popup_fundo != null:
		popup_fundo.queue_free()

	popup_fundo = ColorRect.new()
	popup_fundo.color = Color(0,0,0,0.65)
	popup_fundo.position = Vector2.ZERO
	popup_fundo.size = Vector2(1280,720)

	camada_popup.add_child(popup_fundo)


	popup_imagem = Sprite2D.new()
	popup_imagem.texture = load(imagem)
	popup_imagem.centered = true
	popup_imagem.scale = Vector2(0.7,0.7)
	popup_imagem.position = Vector2(640,350)

	popup_fundo.add_child(popup_imagem)


	# Botão desistir

	var btn_desistir = criar_botao_comando(
		"",
		Vector2(350,560),
		Vector2(250,50)
	)

	btn_desistir.flat = true

	var vazio = StyleBoxEmpty.new()

	btn_desistir.add_theme_stylebox_override("normal",vazio)
	btn_desistir.add_theme_stylebox_override("hover",vazio)
	btn_desistir.add_theme_stylebox_override("pressed",vazio)
	btn_desistir.add_theme_stylebox_override("focus",vazio)

	btn_desistir.pressed.connect(
		func():
			get_tree().change_scene_to_file(
				"res://scenes/jogar.tscn"
			)
	)

	popup_fundo.add_child(btn_desistir)


	# Próxima fase

	var btn_proximo = criar_botao_comando(
		"",
		Vector2(640,560),
		Vector2(280,50)
	)

	btn_proximo.flat = true

	btn_proximo.add_theme_stylebox_override("normal",vazio)
	btn_proximo.add_theme_stylebox_override("hover",vazio)
	btn_proximo.add_theme_stylebox_override("pressed",vazio)
	btn_proximo.add_theme_stylebox_override("focus",vazio)

	btn_proximo.pressed.connect(
		func():
			get_tree().change_scene_to_file(
				dados.proxima
			)
	)

	popup_fundo.add_child(btn_proximo)

#======================================
# CRIAR FUNDO DO GRID
#======================================

func criar_fundo_grid(caminho):

	var fundo = Sprite2D.new()

	fundo.texture = load(caminho)

	fundo.centered = false

	fundo.position = Vector2(
		0,
		MENU_HEIGHT
	)

	# Coloca atrás de todos os outros elementos
	fundo.z_index = -100

	add_child(fundo)
