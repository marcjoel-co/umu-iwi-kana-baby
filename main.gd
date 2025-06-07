extends Node2D

@export var note_scene: PackedScene  # Assign your Note scene here

func _ready():
	$Timer.timeout.connect(_spawn_note)
	$HitBar.hit_judged.connect(_on_hit_judged)

func _spawn_note():
	var note = note_scene.instantiate()
	note.position = Vector2(1000, 0)  # Right side of screen
	add_child(note)

func _on_hit_judged(accuracy: String):
	print("Signal received! Accuracy:", accuracy)  # Debug check
	$JudgmentLabel.text = accuracy.to_upper()
	$JudgmentLabel.modulate.a = 1.0  # Make sure it's visible
