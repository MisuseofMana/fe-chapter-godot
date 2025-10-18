extends AnimatedSprite2D
class_name ActivationButton

var is_active : bool = false:
	set(new):
		if new != is_active:
			is_active = new
			if is_active:
				show_arrow()
			else:
				hide_arrow()
			
func show_arrow():
	play('default')
	
func hide_arrow():
	play_backwards("default")
