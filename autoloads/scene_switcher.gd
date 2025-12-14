extends Node2D

signal level_change_requested(new_level: String)
signal level_change_completed

@warning_ignore("unused_signal")
signal entered_transition_zone(new_level: String, is_decending: bool)

@warning_ignore("unused_signal")
signal level_finished_loading()

@warning_ignore("unused_signal")
signal level_swap_completed(spawn_pos: Vector2)
