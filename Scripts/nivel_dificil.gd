extends "res://Scripts/base_level.gd"

const L = GridManager.TipoBloco.LIVRE
const A = GridManager.TipoBloco.AGUA
const O = GridManager.TipoBloco.OBSTACULO
const M = GridManager.TipoBloco.MOVEDICA
const E = GridManager.TipoBloco.ESPINHO
const C = GridManager.TipoBloco.CHEGADA

func configurar_fase():

	criar_fundo_grid(
		"res://Sprites/Grid/img_fundo_grid_fase3.png"
	)

	criar_imagem_fase(
		"res://Sprites/Grid/Fase3/img_fase3.png"
	)

	grid.definir_posicao_robo(0, 0)

	var mapa = [

		[L, L, L, A, A, A, A, A, A, L, A, A],

		[A, L, A, A, A, L, L, L, L, L, A, A],

		[A, L, L, L, A, L, A, A, A, L, L, L],

		[A, A, A, L, A, L, L, A, L, L, A, A],

		[A, L, L, L, A, A, L, A, L, A, A, A],

		[A, L, A, A, L, A, L, A, L, L, L, A],

		[A, L, L, A, A, L, L, A, A, A, L, L],

		[A, A, L, L, L, L, A, A, A, A, A, C]

	]

	grid.carregar_mapa(mapa)

func obter_pontuacao():

	return {

		"tres":38,
		"duas":41,

		"img3":"res://Sprites/Venceu/img_venceu_3estrelas_fase3.png",
		"img2":"res://Sprites/Venceu/img_venceu_2estrelas_fase3.png",
		"img1":"res://Sprites/Venceu/img_venceu_1estrelas_fase3.png",

		"proxima":"res://Scenes/nivel_facil.tscn"
	}
