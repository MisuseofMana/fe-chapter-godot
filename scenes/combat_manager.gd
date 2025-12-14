extends CanvasLayer
class_name CombatManager

signal won_encounter
signal lost_encounter

func setup_signals(call_on_win: Callable, call_on_lose: Callable):
	won_encounter.connect(call_on_win)
	lost_encounter.connect(call_on_lose)

func skip_combat():
	won_encounter.emit()
