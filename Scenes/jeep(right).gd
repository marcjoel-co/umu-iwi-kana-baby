extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $AnimatableBody2D/AnimationPlayer.get_animation("JeepMovingRight")
	anim.loop_mode = Animation.LOOP_LINEAR
	$AnimatableBody2D/AnimationPlayer.play("JeepMovingRight")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
