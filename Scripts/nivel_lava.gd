extends "res://Scripts/base_level.gd"

const L = GridManager.TipoBloco.LIVRE
const A = GridManager.TipoBloco.AGUA
const O = GridManager.TipoBloco.OBSTACULO
const M = GridManager.TipoBloco.MOVEDICA
const E = GridManager.TipoBloco.ESPINHO
const V = GridManager.TipoBloco.LAVA
const C = GridManager.TipoBloco.CHEGADA

const RobotLava = preload("res://Scripts/robot_lava.gd")

func obter_robot_script():
    return RobotLava

func configurar_fase():

    criar_fundo_grid(
        "res://Sprites/Grid/img_fundo_grid_fase4.png"
    )

    criar_imagem_fase(
        "res://Sprites/Grid/Fase4/img_fase4.png"
    )

    grid.definir_posicao_robo(0, 0)

    var mapa = [

        [L, L, L, V, L, V, L, L, L, L, L, L],

        [O, O, L, V, L, L, L, O, L, V, V, L],

        [L, O, L, V, L, O, O, V, L, L, L, L],

        [O, L, L, O, L, L, L, V, V, L, L, V],

        [V, L, V, V, V, V, L, V, L, L, L, L],

        [L, L, O, L, L, L, L, V, L, V, L, V],

        [L, L, O, L, O, L, L, V, L, L, V, L],

        [O, L, L, L, O, V, O, V, V, L, L, C]

    ]

    grid.carregar_mapa(mapa)

func obter_pontuacao():

    return {

        "quatro":42,
        "tres":44,
        "duas":49,

        "img4":"res://Sprites/Venceu/img_venceu_4estrelas.png",
        "img3":"res://Sprites/Venceu/img_venceu_3estrelas_fase3.png",
        "img2":"res://Sprites/Venceu/img_venceu_2estrelas_fase3.png",
        "img1":"res://Sprites/Venceu/img_venceu_1estrelas_fase3.png",

        "proxima":"res://scenes/jogar.tscn"
    }
