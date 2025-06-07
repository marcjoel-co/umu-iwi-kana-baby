extends Node2D

@export var note_scene: PackedScene

# 1. Create a variable for the total score
var total_score: int = 0

func _ready():
	$HitBar.hit_judged.connect(_on_hit_judged)
	$Timer.timeout.connect(_spawn_note)
	# Initialize the score label at the start
	$ScoreLabel.text = str(total_score)

func _spawn_note():
	var note = note_scene.instantiate()
	note.position = Vector2(1000, $HitBar.position.y)
	add_child(note)

# The 'score' argument here is now the points from a single hit (e.g., 3, 2, or 1)
func _on_hit_judged(accuracy: String, points_gained: int):
	print("Signal received! Accuracy:", accuracy, " Points:", points_gained)
	
	# 2. Add the points from this hit to our total score
	total_score += points_gained
	
	# 3. Update the labels, converting the integer score to a string
	$JudgmentLabel.text = accuracy.to_upper()
	$ScoreLabel.text = str(total_score) # Use str() to convert the number to text
	$JudgmentLabel.modulate.a = 1.0
	
	
func _on_note_was_missed():
	# This function runs when a note hits the MissZone
	print("Note flew past without input. MISS!")
	
	# Update the UI to show "MISS"
	$JudgmentLabel.text = "MISS"
	$JudgmentLabel.modulate.a = 1.0
