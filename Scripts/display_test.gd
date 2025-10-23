extends Window

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	self.queue_free()
