extends Area2D

# Timing windows (milliseconds)
const PERFECT_MS = 50
const GREAT_MS = 100
const GOOD_MS = 150

signal hit_judged(accuracy)  # Define the signal

var closest_note: Area2D = null

func _process(delta):
	closest_note = null
	var min_dist = INF
	for note in get_overlapping_areas():
		var dist = abs(note.position.x - position.x)
		if dist < min_dist:
			min_dist = dist
			closest_note = note

func _input(event):
	if event.is_action_pressed("ui_accept") and closest_note:
		var timing_ms = (closest_note.position.x - position.x) / closest_note.speed * 1000
		var accuracy: String
		
		if abs(timing_ms) <= PERFECT_MS:
			accuracy = "perfect"
		elif abs(timing_ms) <= GREAT_MS:
			accuracy = "great"
		elif abs(timing_ms) <= GOOD_MS:
			accuracy = "good"
		else:
			accuracy = "miss"
		
		emit_signal("hit_judged", accuracy)  # Emit with accuracy
		closest_note.queue_free()
