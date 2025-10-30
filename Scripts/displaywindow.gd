extends Window

@onready var label: Label = %Label

func ExibirGanhador(nome: String):
	label.text = nome

func _on_close_request():
	self.queue_free()
	
func _input(event):
	if event.is_action_pressed("Fechar"):
		get_tree().quit()

#Garantindo que o programa poderá ser fechado caso a janela surja onde não deve
