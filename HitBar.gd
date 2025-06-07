extends Area2D

# Timing windows (milliseconds)
const PERFECT_MS = 50
const GREAT_MS = 100
const GOOD_MS = 150

signal hit_judged(accuracy, score)  # Define the signal

var closest_note: Area2D = null

func _process(delta):
	closest_note = null
	var min_dist = INF
	for note in get_overlapping_areas():
		var dist = abs(note.position.x - position.x)
		if dist < min_dist:
			min_dist = dist
			closest_note = note


# Get a reference to the sound player node at the start of the script.
#@onready var hit_sound_player: AudioStreamPlayer = $HitSoundPlayer


func _input(event):

	if event.is_action_pressed("ui_accept") and closest_note:
		
		var note_to_process = closest_note
		closest_note = null
		var timing_ms = (note_to_process.position.x - position.x) / note_to_process.speed * 1000
		
		var accuracy: String
		var feedback_string: String
		var score = 0
		
		if abs(timing_ms) <= PERFECT_MS:
			accuracy = "perfect"
			score = 3
		elif abs(timing_ms) <= GREAT_MS:
			accuracy = "great"
			score = 2
		elif abs(timing_ms) <= GOOD_MS:
			accuracy = "good"
			score = 1
		else:
			accuracy = "miss"
			score = 0
		
		feedback_string = accuracy
		if accuracy == "great" or accuracy == "good":
			if timing_ms > 0:
				feedback_string += " EARLY"
			else:
				feedback_string += " LATE"
		
		emit_signal("hit_judged", feedback_string, score)
	
		note_to_process.set_collision_layer_value(2, false)

		var tween = create_tween()
		tween.set_parallel()

		tween.tween_property(note_to_process, "scale", Vector2(1.5, 1.5), 0.1)\
			.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
			
		tween.tween_property(note_to_process, "modulate:a", 0.0, 0.2).set_delay(0.05)
		tween.tween_callback(note_to_process.queue_free)
