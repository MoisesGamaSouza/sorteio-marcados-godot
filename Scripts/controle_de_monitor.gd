extends VBoxContainer

@onready var om = %OptionButton #Opções de Monitores
@onready var st = %"Segunda Tela"
var testwin = preload("res://Scenes/DisplayTest.tscn")
var mywin = preload("res://Scenes/DisplayWindow.tscn")

func _ready() -> void:
	atualizarMonitores()
		
func ativarSegundaTela(i): #Função que recebe o ID do monitor escolhido e Cria a segunda tela
	FecharTela()#teste para conferir se já não há uma segunda tela criada, e se houver, fechando ela antes de abrir outra
	
	var d = mywin.instantiate() 
	st.add_child(d) #Adicionando o Nó da tela como filho e logo em seguida Configurando seus atributos
	d.visible = true
	d.position = DisplayServer.screen_get_position(i) #estará posicionado no Monitor Escolhido
	d.size = DisplayServer.screen_get_size(i) #Tera o tamanho maximo do monitor escolhido
	d.always_on_top = true #Estará sempre no topo
	#d.borderless = true #Não terá borda
	
	Global.wininstance = d #Guardando a inscancia da janela em uma variavel para maior controle

func FecharTela():
	if Global.wininstance != null:
		Global.wininstance.queue_free()
		#Global.wininstance = null

func atualizarMonitores() -> void:
	om.clear()	#Limpando a Lista de Seleção
	# Adicionando os monitores presentes no computador dentro da lista de seleção
	for i in range(DisplayServer.get_screen_count()):
		om.add_item(str(i))

# Função que cria uma janela como uma especie de PopUp para mostrar qual monitor está sendo selecionado antes de de fato criar a janela principal nele.
func testeMonitor(index: int) -> void:
	var d = testwin.instantiate()
	st.add_child(d)
	d.visible = true
	d.position = DisplayServer.screen_get_position(index)
	d.title = "Monitor Selecionado"
	d.size = Vector2(100, 100)
	d.always_on_top = true
	d.get_node("Label").text = str(om.get_selected_id())



func _on_button_test_pressed() -> void:
	testeMonitor(om.get_selected_id())
	pass # Replace with function body.

func _on_button_apply_pressed() -> void:
	ativarSegundaTela(om.get_selected_id())

func _on_button_fechar_pressed() -> void:
	FecharTela()
