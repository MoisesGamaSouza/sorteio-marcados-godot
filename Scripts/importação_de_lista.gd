extends Control

@onready var file_dialog = $FileDialog
@onready var IL_C = $ItemList_Categorias
@onready var info = $"../InfoPopup"

func ListarTiposNomes():
	print(Global.lista_json.keys())
	for i in range(Global.lista_json.keys().size()):
		IL_C.add_item(str(Global.lista_json.keys().get(i)))

func ListarNomes():
	$ItemList_Itens.clear()
	
	var SI = IL_C.get_selected_items() #Pega um Array com os itens selecionados
	print("Itens Selecionados: ", SI)
	
	for i in range(SI.size()): #Rodo um For dentro desse Array de itens selecionados
		print(SI.get(i))
		#Pego dentro do Dicionario o Array com a lista dos nomes baseado na categoria que está rodando no momento dentro do for
		var ListaNomesPorCategoria = Global.lista_json.get(IL_C.get_item_text(SI.get(i)))
		print(ListaNomesPorCategoria)
		
		for f in range(ListaNomesPorCategoria.size()):
			$ItemList_Itens.add_item(ListaNomesPorCategoria.get(f))

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
		
		
	
