extends Control

@onready var file_dialog = $FileDialog

func ListarTiposNomes():
	Global.lista_json.has("meninos")
	print(Global.lista_json.keys())
	for i in range(Global.lista_json.keys().size()):
		$ItemList.add_item(str(Global.lista_json.keys().get(i)))

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
			$ErrorPopup.dialog_text = "Erro: O arquivo não contém um JSON válido."
			$ErrorPopup.popup_centered()
			push_error("Erro: O arquivo não contém um JSON válido.")
			
