extends CanvasLayer
class_name HUD

@onready var confirm_button = %ConfirmButton

var confirm_button_is_active : bool = false:
	set(new):
		if new != confirm_button_is_active:
			confirm_button_is_active = new
			if confirm_button_is_active:
				show_confirm_arrow()
			else:
				hide_confirm_arrow()

func show_confirm_arrow():
	confirm_button.play('default')
	
func hide_confirm_arrow():
	confirm_button.play_backwards("default")
