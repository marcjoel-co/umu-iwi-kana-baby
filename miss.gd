extends Area2D

signal note_was_missed


func _ready():
	# Connect the built-in "area_entered" signal to a function in this script.
	# When any other Area2D enters our shape, the _on_area_entered function will run.
	area_entered.connect(_on_area_entered)

func _on_area_entered(note: Area2D):
	# A note has entered our zone. This means the player failed to hit it.
	
	# Tell the main game loop that a miss occurred.
	emit_signal("note_was_missed")
	# MissZone
	
	note.set_collision_layer_value(2, false)
	var tween = create_tween()	
	tween.tween_property(note, "modulate:a", 0, 0.3)
	tween.tween_callback(note.queue_free)
