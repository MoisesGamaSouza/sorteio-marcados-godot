extends Control

@onready var ListaItens = $"../Importação de Lista/ItemList_Itens"
@onready var info = $"../InfoPopup"


func ApresentarSorteado(nome: String):
	info.dialog_text = "Ganhador: " + nome
	info.popup_centered()
	
	if Global.wininstance != null:
		Global.wininstance.ExibirGanhador(nome)

func SortearSelecionado():
	if ListaItens.get_selected_items().is_empty():
		push_error("Nenhum item selecionado")
		info.dialog_text = "Erro: Nenhum item selecionado."
		info.popup_centered()
	else:
		ApresentarSorteado(ListaItens.get_item_text(ListaItens.get_selected_items().get(0)))

func SortearTodos():
	if ListaItens.item_count != 0:
		randomize()
		ApresentarSorteado(ListaItens.get_item_text(randi_range(0, ListaItens.item_count-1)))
	else:
		push_error("Erro: Nenhum grupo selecionado!")
		info.dialog_text = "Erro: Nenhum grupo selecionado!"
		info.popup_centered()

func ListaDeNomesAptos():
	pass
	

func _on_sortear_selecionado_pressed() -> void:
	SortearSelecionado()
	
func _on_sortear_todos_pressed() -> void:
	SortearTodos()
