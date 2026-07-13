extends "res://Scripts/base_level.gd"

const L = GridManager.TipoBloco.LIVRE
const A = GridManager.TipoBloco.AGUA
const O = GridManager.TipoBloco.OBSTACULO
const C = GridManager.TipoBloco.CHEGADA

func configurar_fase():

	criar_fundo_grid(
		"res://Sprites/Grid/img_fundo_grid_fase1.png"
	)

	criar_imagem_fase(
		"res://Sprites/Grid/Fase1/img_fase1.png"
	)

	grid.definir_posicao_robo(0, 0)

	var mapa = [

		[L, L, O, A, A, L, L, L, A, O, L, L],

		[L, L, L, L, L, L, A, O, L, L, A, L],

		[L, O, A, A, O, L, A, L, L, A, A, O],

		[L, L, L, L, L, L, L, L, O, L, L, L],

		[L, A, O, L, A, A, O, L, O, L, L, A],

		[A, A, L, L, O, A, A, L, L, O, A, A],

		[L, L, A, A, L, L, L, O, L, L, L, O],

		[L, O, L, L, L, O, L, L, A, A, L, C]

	]

	grid.carregar_mapa(mapa)

func obter_pontuacao():

	return {

		"tres":18,
		"duas":21,

		"img3":"res://Sprites/Venceu/img_venceu_3estrelas.png",
		"img2":"res://Sprites/Venceu/img_venceu_2estrelas.png",
		"img1":"res://Sprites/Venceu/img_venceu_1estrelas.png",

		"proxima":"res://scenes/nivel_medio.tscn"
	}
