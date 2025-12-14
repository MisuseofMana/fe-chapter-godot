extends CanvasLayer
class_name AnimatedTransition

@onready var anims: AnimationPlayer = $AnimationPlayer

signal fade_to_black_completed
	
func fade_in():
	anims.play('fade_in')
	
func fade_out():
	anims.play('fade_out')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		fade_to_black_completed.emit()
