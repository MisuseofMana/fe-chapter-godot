extends Node2D

@warning_ignore("unused_signal")
signal entered_transition_zone(new_level: String, is_decending: bool)

@warning_ignore("unused_signal")
signal level_finished_loading()

@warning_ignore("unused_signal")
signal level_swap_completed(spawn_pos: Vector2)
