class_name Sorteio

var accept_dialog_pop_up
var item_list_itens

func _init(accept: AcceptDialog, item_list: ItemList):
	accept_dialog_pop_up = accept
	item_list_itens = item_list
	
	randomize()

func apresentar(nome: String):
	accept_dialog_pop_up.dialog_text = "Ganhador: " + nome
	accept_dialog_pop_up.popup_centered()
	
	if Global.wininstance != null:
		Global.wininstance.ExibirGanhador(nome)

func apresentarSelecionado():
	if item_list_itens.get_selected_items().is_empty():
		push_error("Nenhum item selecionado")
		accept_dialog_pop_up.dialog_text = "Erro: Nenhum item selecionado."
		accept_dialog_pop_up.popup_centered()
	else:
		apresentar(item_list_itens.get_item_text(item_list_itens.get_selected_items().get(0)))

func sortear():
	if item_list_itens.item_count != 0:
		#randomize()
		apresentar(item_list_itens.get_item_text(randi_range(0, item_list_itens.item_count-1)))
	else:
		push_error("Erro: Nenhum grupo selecionado!")
		accept_dialog_pop_up.dialog_text = "Erro: Nenhum grupo selecionado!"
		accept_dialog_pop_up.popup_centered()
