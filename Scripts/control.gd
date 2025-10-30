extends Control

#PACKED SCENES
var mywin = preload("res://Scenes/DisplayWindow.tscn")
var testwin = preload("res://Scenes/DisplayTest.tscn")

#NODES
@onready var option_button_monitores: OptionButton = %"OptionButton-Monitores"
@onready var file_dialog_import: FileDialog = %FileDialog_Import
@onready var file_dialog_save: FileDialog = %FileDialog_Save
@onready var accept_dialog_pop_up: AcceptDialog = %AcceptDialog_PopUp
@onready var item_list_categorias: ItemList = %ItemList_Categorias
@onready var item_list_itens: ItemList = %ItemList_Itens
@onready var line_edit: LineEdit = %LineEdit

#OBJECTS
@onready var SORTEIO = Sorteio.new(accept_dialog_pop_up, item_list_itens)
@onready var CONTROLE_SEGUNDA_TELA = ControleSegundaTela.new(mywin, testwin, self, option_button_monitores)
@onready var GERENCIADOR_LISTA = GerenciadorLista.new(item_list_categorias, item_list_itens, accept_dialog_pop_up)


func _ready():
	CONTROLE_SEGUNDA_TELA.getMonitores()

#Garantindo que o programa poderá ser fechado caso a janela surja onde não deve
func _input(event):
	if event.is_action_pressed("Fechar"):
		get_tree().quit()


#CONEXÕES - APRESENTAÇÃO E CONTROLE DA SEGUNDA TELA
func _on_button_apply_pressed() -> void:
	CONTROLE_SEGUNDA_TELA.ativarSegundaTela(option_button_monitores.get_selected_id())

func _on_button_close_pressed() -> void:
	CONTROLE_SEGUNDA_TELA.fecharTela()

func _on_button_test_pressed() -> void:
	CONTROLE_SEGUNDA_TELA.testeMonitor(option_button_monitores.get_selected_id())

#CONEXÕES - IMPORTAÇÃO E CRIAÇÃO DE LISTA
func _on_button_import_pressed() -> void:
	file_dialog_import.popup_centered()

func _on_button_model_pressed() -> void:
	file_dialog_save.popup_centered()

func _on_file_dialog_import_file_selected(path: String) -> void:
	if GERENCIADOR_LISTA.acessarJson(path):
		GERENCIADOR_LISTA.listarCategorias()

func _on_item_list_categorias_multi_selected(_index: int, _selected: bool) -> void:
	GERENCIADOR_LISTA.listarItens()

func _on_file_dialog_save_file_selected(path: String) -> void:
	GERENCIADOR_LISTA.saveJsonModel(path)

#CONEXÕES - SORTEIO
func _on_button_sortear_pressed() -> void:
	SORTEIO.sortear()

func _on_button_apresentar_selecionado_pressed() -> void:
	SORTEIO.apresentarSelecionado()

func _on_button_apresentar_pressed() -> void:
	if line_edit.text != "":
		SORTEIO.apresentar(line_edit.text)
		line_edit.clear()
	else:
		accept_dialog_pop_up.dialog_text = "O Campo está vazio!"
		accept_dialog_pop_up.popup_centered()
