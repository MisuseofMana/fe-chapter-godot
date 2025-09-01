extends TextureRect

signal menu_icon_pressed

func _on_gui_input(event):
	if event.is_pressed():
		menu_icon_pressed.emit()
