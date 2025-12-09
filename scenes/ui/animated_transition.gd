extends CanvasLayer
class_name AnimatedTransition

@onready var anims: AnimationPlayer = $AnimationPlayer

func _ready():
	SceneSwitcher.entered_transition_zone.connect(fade_in.unbind(2))
	SceneSwitcher.level_swap_completed.connect(fade_out.unbind(1))
	
func fade_in():
	anims.play('fade_in')
	
func fade_out():
	anims.play('fade_out')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'fade_in':
		SceneSwitcher.level_finished_loading.emit()
		
