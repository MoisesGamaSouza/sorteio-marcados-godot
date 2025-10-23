extends Control

var mywin = preload("res://Scenes/DisplayWindow.tscn")
var wininstance

func _ready():
	pass

func ativarSegundaTela(i): #Função que recebe o ID do monitor escolhido e Cria a segunda tela
	if wininstance != null: #teste para conferir se já não há uma segunda tela criada, e se houver, fechando ela antes de abrir outra
		wininstance.queue_free()
	
	var d = mywin.instantiate() 
	add_child(d) #Adicionando o Nó da tela como filho e logo em seguida Configurando seus atributos
	d.visible = true
	d.position = DisplayServer.screen_get_position(i) #estará posicionado no Monitor Escolhido
	d.size = DisplayServer.screen_get_size(i) #Tera o tamanho maximo do monitor escolhido
	d.always_on_top = true #Estará sempre no topo
	#d.borderless = true #Não terá borda
	
	wininstance = d #Guardando a inscancia da janela em uma variavel para maior controle

#Garantindo que o programa poderá ser fechado caso a janela surja onde não deve
func _input(event):
	if event.is_action_pressed("Fechar"):
		get_tree().quit()


func _on_button_apply_pressed() -> void:
	ativarSegundaTela(get_node("Controle de Monitor/OptionButton").get_selected_id())


func _on_button_fechar_pressed() -> void:
	if wininstance != null:
		wininstance.queue_free()
