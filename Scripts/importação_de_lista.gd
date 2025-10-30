extends Control

@onready var file_dialog = $FileDialog
@onready var IL_C = $ItemList_Categorias
@onready var info = $"../InfoPopup"
@onready var item_list_itens: ItemList = %ItemList_Itens

func ListarTiposNomes():
	print(Global.lista_json.keys())
	for i in range(Global.lista_json.keys().size()):
		IL_C.add_item(str(Global.lista_json.keys().get(i)))

func ListarNomes():
	item_list_itens.clear()
	
	var SI: PackedInt32Array = IL_C.get_selected_items() #Pega um Array com os itens selecionados
	# print("Itens Selecionados: ", SI) # = [0]
	for i in SI: #Rodo um For dentro desse Array de itens selecionados
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
		var ListaNomesPorCategoria: Array = Global.lista_json.get(IL_C.get_item_text(i))
		
		#Dentro das categorias, tem um Array com os nomes pertencentes a essa categoria
		#Nesse for entramos dentro desse array e rodamos uma 
		for f in ListaNomesPorCategoria:
			#print(f)
			item_list_itens.add_item(f)

func _on_button_import_pressed() -> void:
	file_dialog.popup_centered()

func _on_file_dialog_file_selected(path: String) -> void:
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
			ListarTiposNomes()
		else:
			info.dialog_text = "Erro: O arquivo não contém um JSON válido."
			info.popup_centered()
			push_error("Erro: O arquivo não contém um JSON válido.")

func _on_item_list_categorias_multi_selected(_index: int, _selected: bool) -> void:
	ListarNomes()
		
		
	
