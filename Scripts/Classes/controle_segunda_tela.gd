class_name ControleSegundaTela

var mywin
var testwin
var node
var option_button_monitores

func _init(mw: PackedScene, tw: PackedScene, n: Node, obm: OptionButton) -> void:
	mywin = mw
	testwin = tw
	node = n
	option_button_monitores = obm

#FUNÇÕES - APRESENTAÇÃO E CONTROLE DA SEGUNDA TELA
func ativarSegundaTela(ID): #Função que recebe o ID do monitor escolhido e Cria a segunda tela
	fecharTela()#teste para conferir se já não há uma segunda tela criada, e se houver, fechando ela antes de abrir outra
	
	var d = mywin.instantiate() 
	node.add_child(d) #Adicionando o Nó da tela como filho e logo em seguida Configurando seus atributos
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
	node.add_child(d)
	d.visible = true
	d.position = DisplayServer.screen_get_position(ID)
	d.title = "Monitor Selecionado"
	d.size = Vector2(100, 100)
	d.always_on_top = true
	d.get_node("Label").text = str(option_button_monitores.get_selected_id())
