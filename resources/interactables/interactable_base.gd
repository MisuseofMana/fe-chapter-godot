@abstract
extends Resource
class_name Interactable

@export var action_triggers : Array[Action] = []
@export var interaction_sounds : AudioStreamRandomizer

func get_state(): pass
func set_state(_newState): pass
func handle_interaction(_passed_action): pass
