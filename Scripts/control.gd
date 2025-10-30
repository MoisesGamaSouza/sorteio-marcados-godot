extends Control

#VARIAVEIS
var mywin = preload("res://Scenes/DisplayWindow.tscn")
var testwin = preload("res://Scenes/DisplayTest.tscn")

@onready var option_button_monitores: OptionButton = %"OptionButton-Monitores"
@onready var file_dialog_import: FileDialog = %FileDialog_Import
@onready var file_dialog_save: FileDialog = %FileDialog_Save
@onready var accept_dialog_pop_up: AcceptDialog = %AcceptDialog_PopUp
@onready var item_list_categorias: ItemList = %ItemList_Categorias
@onready var item_list_itens: ItemList = %ItemList_Itens

#OBJETOS
@onready var SORTEIO = Sorteio.new(accept_dialog_pop_up, item_list_itens)


func _ready():
	getMonitores()

#Garantindo que o programa poderá ser fechado caso a janela surja onde não deve
func _input(event):
	if event.is_action_pressed("Fechar"):
		get_tree().quit()


#FUNÇÕES - APRESENTAÇÃO E CONTROLE DA SEGUNDA TELA
func ativarSegundaTela(ID): #Função que recebe o ID do monitor escolhido e Cria a segunda tela
	fecharTela()#teste para conferir se já não há uma segunda tela criada, e se houver, fechando ela antes de abrir outra
	
	var d = mywin.instantiate() 
	add_child(d) #Adicionando o Nó da tela como filho e logo em seguida Configurando seus atributos
	d.visible = true
	d.position = DisplayServer.screen_get_position(ID) #estará posicionado no Monitor Escolhido
	d.size = DisplayServer.screen_get_size(ID) #Tera o tamanho maximo do monitor escolhido
	d.always_on_top = true #Estará sempre no topo
	#d.borderless = true #Não terá borda
	
	Global.wininstance = d #Guardando a inscancia da janela em uma variavel para maior controle

func fecharTela():
	if Global.wininstance != null:
		Global.wininstance.queue_free()
		#Global.wininstance = null

func getMonitores():
	option_button_monitores.clear()	#Limpando a Lista de Seleção
	
	# Adicionando os monitores presentes no computador dentro da lista de seleção
	for i in range(DisplayServer.get_screen_count()):
		option_button_monitores.add_item(str(i))

func testeMonitor(ID):
	var d = testwin.instantiate()
	add_child(d)
	d.visible = true
	d.position = DisplayServer.screen_get_position(ID)
	d.title = "Monitor Selecionado"
	d.size = Vector2(100, 100)
	d.always_on_top = true
	d.get_node("Label").text = str(option_button_monitores.get_selected_id())

#FUNÇÕES - IMPORTAÇÃO E CRIAÇÃO DE LISTA
func listarCategorias():
	print(Global.lista_json.keys())
	for i in range(Global.lista_json.keys().size()):
		item_list_categorias.add_item(str(Global.lista_json.keys().get(i)))

func listarItens():
	item_list_itens.clear()
	
	var SELECTED_ITENS: PackedInt32Array = item_list_categorias.get_selected_items() #Pega um Array com os itens selecionados
	# print("Itens Selecionados: ", SI) # = [0]
	for i in SELECTED_ITENS: #Rodo um For dentro desse Array de itens selecionados
		# print(SI.get(i))
		#Se eu rodar um for diretamento de um array, o index sera os itens dentro do Array e não o intex deles
		#Ex: 
		#var Array = [1, 3]
		#for i in Array 
		#i = -> 1 -> 3
		#
		#for i in range(Array.size())
		#i = -> 0 -> 1
		#Pego dentro do Dicionario o Array com a lista dos nomes baseado na categoria que está rodando no momento dentro do for
		var ListaItensPorCategoria: Array = Global.lista_json.get(item_list_categorias.get_item_text(i))
		
		#Dentro das categorias, tem um Array com os nomes pertencentes a essa categoria
		#Nesse for entramos dentro desse array e rodamos uma 
		for f in ListaItensPorCategoria:
			#print(f)
			item_list_itens.add_item(f)
	
func acessarJson(path: String) -> bool:
	print("Arquivo selecionado:", path)

	# Carrega o arquivo JSON
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		Global.lista_json = JSON.parse_string(text)
		file.close()
		
		# or typeof(Global.lista_json) == TYPE_ARRAY
		if typeof(Global.lista_json) == TYPE_DICTIONARY:
			print("JSON carregado com sucesso!:")
			# Aqui você pode manipular a lista como quiser
			return true
		else:
			accept_dialog_pop_up.dialog_text = "Erro: O arquivo não contém um JSON válido."
			accept_dialog_pop_up.popup_centered()
			push_error("Erro: O arquivo não contém um JSON válido.")
			return false
			
	return false
	
func saveJsonModel(path: String):
	#Acessando o local do arquivo Json salvo em Assets, com permissão de leitura
	var file = FileAccess.open("res://Assets/List.json", FileAccess.READ)
	#Transformando o arquivo em uma string e ja formatada na forma de um json e salvando em uma variavel
	var arquivo = JSON.parse_string(file.get_as_text())
	#fechando o acesso
	file.close()
	
	#Garantindo que o caminho termina com .json
	if !path.ends_with(".json"):
		path += ".json"
	
	#Acessando o caminho escolhido no FileDialog com a permição de escrita
	file = FileAccess.open(path, FileAccess.WRITE)
	#Escrevendo nesse caminho um arquivo Json a partir de uma string obtida pelo proprio arquivo json no sistema
	#O \t serve como forma de formatar o texto, para que esteja nas linhas corretas e não tudo em uma linha só
	file.store_string(JSON.stringify(arquivo,"\t"))
	#Fechando o acesso ao caminho
	file.close()

#FUNÇÕES - SORTEIO


#CONEXÕES - APRESENTAÇÃO E CONTROLE DA SEGUNDA TELA
func _on_button_apply_pressed() -> void:
	ativarSegundaTela(option_button_monitores.get_selected_id())

func _on_button_close_pressed() -> void:
	fecharTela()

func _on_button_test_pressed() -> void:
	testeMonitor(option_button_monitores.get_selected_id())

#CONEXÕES - IMPORTAÇÃO E CRIAÇÃO DE LISTA
func _on_button_import_pressed() -> void:
	file_dialog_import.popup_centered()

func _on_button_model_pressed() -> void:
	file_dialog_save.popup_centered()

func _on_file_dialog_import_file_selected(path: String) -> void:
	if acessarJson(path):
		listarCategorias()

func _on_item_list_categorias_multi_selected(_index: int, _selected: bool) -> void:
	listarItens()

func _on_file_dialog_save_file_selected(path: String) -> void:
	saveJsonModel(path)

#CONEXÕES - SORTEIO
func _on_button_sortear_pressed() -> void:
	SORTEIO.sortear()

func _on_button_apresentar_selecionado_pressed() -> void:
	SORTEIO.apresentarSelecionado()
