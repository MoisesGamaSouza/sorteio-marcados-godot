extends Control

@onready var om = $OptionButton #Opções de Monitores
var testwin = preload("res://Scenes/DisplayTest.tscn")

func _ready() -> void:
	om.clear()	#Limpando a Lista de Seleção
	
	# Adicionando os monitores presentes no computador dentro da lista de seleção
	for i in range(DisplayServer.get_screen_count()):
		om.add_item(str(i))
		
# Função que cria uma janela como uma especie de PopUp para mostrar qual monitor está sendo selecionado antes de de fato criar a janela principal nele.
func testeMonitor(i):
	var d = testwin.instantiate()
	add_child(d)
	d.visible = true
	d.position = DisplayServer.screen_get_position(i)
	d.title = "Monitor Selecionado"
	d.size = Vector2(100, 100)
	d.always_on_top = true
	d.get_node("Label").text = str($OptionButton.get_selected_id())
	
func _on_button_test_pressed() -> void:
	testeMonitor($OptionButton.get_selected_id())
	pass # Replace with function body.
