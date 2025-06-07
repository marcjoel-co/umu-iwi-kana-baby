extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $"Jeep(left)/AnimationPlayer".get_animation("movingJeep")
	anim.loop_mode = Animation.LOOP_LINEAR
	$"Jeep(left)/AnimationPlayer".play("movingJeep")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
