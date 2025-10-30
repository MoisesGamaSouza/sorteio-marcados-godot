class_name GerenciadorLista

var item_list_categorias
var item_list_itens
var accept_dialog_pop_up

func _init(IL_C: ItemList, IL_I: ItemList, pop_up: AcceptDialog) -> void:
	item_list_categorias = IL_C
	item_list_itens = IL_I
	accept_dialog_pop_up = pop_up
	

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
