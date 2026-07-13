extends "res://Scripts/base_level.gd"

const L = GridManager.TipoBloco.LIVRE
const A = GridManager.TipoBloco.AGUA
const O = GridManager.TipoBloco.OBSTACULO
const M = GridManager.TipoBloco.MOVEDICA
const E = GridManager.TipoBloco.ESPINHO
const C = GridManager.TipoBloco.CHEGADA

func configurar_fase():

	criar_fundo_grid(
		"res://Sprites/Grid/img_fundo_grid_fase2.png"
	)

	criar_imagem_fase(
		"res://Sprites/Grid/Fase2/img_fase2.png"
	)

	grid.definir_posicao_robo(0, 0)

	var mapa = [

		[L, L, L, M, A, E, L, L, L, L, O, L],

		[O, L, L, A, A, L, L, L, A, L, E, A],

		[A, E, L, L, L, L, M, L, E, L, A, A],

		[A, L, E, O, E, L, L, L, L, L, A, O],

		[L, M, M, L, L, L, L, L, E, O, A, M],

		[L, L, A, A, L, O, O, A, A, L, L, L],

		[A, L, L, E, L, L, L, L, A, L, O, L],

		[L, O, L, L, O, M, E, L, L, L, E, C]

	]

	grid.carregar_mapa(mapa)

func obter_pontuacao():

	return {

		"tres":24,
		"duas":27,

		"img3":"res://Sprites/Venceu/img_venceu_3estrelas.png",
		"img2":"res://Sprites/Venceu/img_venceu_2estrelas.png",
		"img1":"res://Sprites/Venceu/img_venceu_1estrelas.png",

		"proxima":"res://scenes/nivel_dificil.tscn"
	}
