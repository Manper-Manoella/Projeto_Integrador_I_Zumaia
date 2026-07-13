extends Node2D

const BACKGROUND_COLOR = Color("f7f9fc")

var bloco_atual = 0

var blocos = [
	{
		"titulo":"",
		"texto":"Zumaia é um jogo para aprender pensamento computacional brincando!\n\nSeu objetivo é ajudar o robô a chegar até a linha de chegada sem cair na água.\n\nPara isso, você deve montar uma sequência de comandos."
	},

	{
		"titulo":"Comandos",
		"texto":"Esses comandos são os passos que o robô vai seguir.\n\nVocê pode usar os botões:\n\n[img=32]res://Sprites/Botoes/img_botao_subir.png[/img] [img=32]res://Sprites/Botoes/img_botao_esquerda.png[/img] [img=32]res://Sprites/Botoes/img_botao_direita.png[/img] [img=32]res://Sprites/Botoes/img_botao_descer.png[/img]\n\nDepois de escolher os comandos, clique em:\n\n[color=white][bgcolor=#025da6] Iniciar [/bgcolor][/color]\n\nO robô vai executar os passos sozinho." 
	},

	{
		"titulo":"Cuidado",
		"texto":"Se o robô sair do caminho seu algoritmo dá erro.\n\nEntão você precisa:\n\n• pensar\n• testar\n• corrigir os comandos"
	},

	{
		"titulo":"Pontuação",
		"texto":"Quanto melhor for o seu algoritmo, maior será sua pontuação!\n\nVocê pode ganhar:\n\n⭐ 1 estrela\n⭐⭐ 2 estrelas\n⭐⭐⭐ 3 estrelas\n⭐⭐⭐⭐ 4 estrelas (só na fase Lendária!)\n\nUse menos passos para ganhar mais estrelas!"
	},

	{
		"titulo":"Desafio",
		"texto":"Cada fase fica mais difícil:\n\n🌲 Fácil\n🌵 Médio\n🌊 Difícil\n🌋 Lendária\n\nBoa sorte e divirta-se aprendendo!"
	}
]

var titulo_bloco
var texto_bloco
var caixa_bloco

var btn_esquerda
var btn_direita

var estilo_seta_esquerda
var estilo_seta_direita

var seta_esquerda_ativa = true
var seta_direita_ativa = true

# =========================================================
# READY
# =========================================================

func _ready():
	criar_fundo()
	GlobalUI.criar_menu_superior(self)
	criar_titulo()
	criar_bloco_interativo()

# =========================================================
# FUNDO
# =========================================================

func criar_fundo():
	var fundo = ColorRect.new()
	fundo.color = BACKGROUND_COLOR
	fundo.size = Vector2(GlobalUI.WINDOW_WIDTH, GlobalUI.WINDOW_HEIGHT)
	add_child(fundo)

# =========================================================
# TÍTULO
# =========================================================

func criar_titulo():
	var titulo = Label.new()
	titulo.text = "COMO JOGAR"
	titulo.position = Vector2(430, 110)
	titulo.add_theme_font_size_override("font_size", 40)
	titulo.add_theme_color_override("font_color", Color("025da6"))
	add_child(titulo)

# =========================================================
# BLOCO INTERATIVO
# =========================================================

func criar_bloco_interativo():
	caixa_bloco = Control.new()
	caixa_bloco.position = Vector2(180, 190)
	caixa_bloco.size = Vector2(920, 380)
	add_child(caixa_bloco)

	titulo_bloco = Label.new()
	titulo_bloco.position = Vector2(40, 20)
	titulo_bloco.add_theme_font_size_override("font_size", 34)
	titulo_bloco.add_theme_color_override("font_color", Color("5f9fd9"))
	caixa_bloco.add_child(titulo_bloco)

	texto_bloco = RichTextLabel.new()
	texto_bloco.bbcode_enabled = true # Ativa o BBCode para mostrar as cores e imagens
	texto_bloco.position = Vector2(40, 90)
	texto_bloco.size = Vector2(760, 260)
	texto_bloco.scroll_active = false
	texto_bloco.fit_content = true
	texto_bloco.add_theme_color_override("default_color", Color.BLACK)
	texto_bloco.add_theme_font_size_override("normal_font_size", 20)
	caixa_bloco.add_child(texto_bloco)

	# Botões de Navegação (Setas)
	btn_esquerda = Button.new()
	btn_esquerda.text = "◀"
	btn_esquerda.position = Vector2(70, 340)
	btn_esquerda.size = Vector2(70, 70)
	btn_esquerda.add_theme_font_size_override("font_size", 30)
	btn_esquerda.pressed.connect(voltar_bloco)
	add_child(btn_esquerda)

	btn_direita = Button.new()
	btn_direita.text = "▶"
	btn_direita.position = Vector2(1140, 340)
	btn_direita.size = Vector2(70, 70)
	btn_direita.add_theme_font_size_override("font_size", 30)
	btn_direita.pressed.connect(avancar_bloco)
	add_child(btn_direita)

	estilo_seta_esquerda = estilizar_botao_arredondado(btn_esquerda, Color("025da6"))
	estilo_seta_direita = estilizar_botao_arredondado(btn_direita, Color("025da6"))

	atualizar_bloco()

# =========================================================
# FUNÇÃO PARA ARREDONDAR QUALQUER BOTÃO
# =========================================================
func estilizar_botao_arredondado(botao, cor_base):
	var normal = StyleBoxFlat.new()
	normal.bg_color = cor_base
	normal.set_corner_radius_all(15) # Valor do arredondamento

	var hover = StyleBoxFlat.new()
	hover.bg_color = cor_base.lightened(0.2)
	hover.set_corner_radius_all(15)

	var pressed = StyleBoxFlat.new()
	pressed.bg_color = cor_base.darkened(0.2)
	pressed.set_corner_radius_all(15)

	botao.add_theme_stylebox_override("normal", normal)
	botao.add_theme_stylebox_override("hover", hover)
	botao.add_theme_stylebox_override("pressed", pressed)
	botao.add_theme_stylebox_override("focus", normal)
	botao.add_theme_color_override("font_color", Color.WHITE)

	return normal

# =========================================================
# NAVEGAÇÃO
# =========================================================

func avancar_bloco():
	if not seta_direita_ativa: return
	if bloco_atual < blocos.size() - 1:
		bloco_atual += 1
		atualizar_bloco()

func voltar_bloco():
	if not seta_esquerda_ativa: return
	if bloco_atual > 0:
		bloco_atual -= 1
		atualizar_bloco()

func atualizar_bloco():
	var bloco = blocos[bloco_atual]
	titulo_bloco.text = bloco["titulo"]
	texto_bloco.text = bloco["texto"]

	if bloco_atual == 0:
		seta_esquerda_ativa = false
		estilo_seta_esquerda.bg_color = Color("e0eeff")
		btn_esquerda.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		seta_esquerda_ativa = true
		estilo_seta_esquerda.bg_color = Color("025da6")
		btn_esquerda.mouse_filter = Control.MOUSE_FILTER_STOP

	if bloco_atual == blocos.size() - 1:
		seta_direita_ativa = false
		estilo_seta_direita.bg_color = Color("e0eeff")
		btn_direita.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		seta_direita_ativa = true
		estilo_seta_direita.bg_color = Color("025da6")
		btn_direita.mouse_filter = Control.MOUSE_FILTER_STOP
