extends Container

@onready var SAVE_WINDOW = %FileDialog_Save_Modelo

func _on_button_modelo_pressed() -> void:
	SAVE_WINDOW.popup_centered()
	


func _on_file_dialog_save_modelo_file_selected(path: String) -> void:
	#Acessando o local do arquivo Json salvo em Assets, com permissão de leitura
	var file = FileAccess.open("res://Assets/Modelo_Lista_Participantes.json", FileAccess.READ)
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
	
