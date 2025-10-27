extends Control

#var mywin = preload("res://Scenes/DisplayWindow.tscn")

func _ready():
	pass

#Garantindo que o programa poderá ser fechado caso a janela surja onde não deve
func _input(event):
	if event.is_action_pressed("Fechar"):
		get_tree().quit()
