extends Area2D

var speed = 400  # How fast it moves left

func _process(delta):
	position.x -= speed * delta  # Move left
	if position.x < -50:  # If off-screen
		queue_free()  # Delete note
