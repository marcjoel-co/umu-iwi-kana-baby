extends CharacterBody2D
# player.gd

const GRID_SIZE = 32
var is_moving = false
var score = 0

# We will connect this to the ScoreLabel later
signal score_updated(new_score)

func _unhandled_input(event):
	if is_moving:
		return # Prevent input while already hopping

	var move_direction = Vector2.ZERO
	if event.is_action_just_pressed("move_forward"):
		move_direction.y = -1
	elif event.is_action_just_pressed("move_back"):
		move_direction.y = 1
	elif event.is_action_just_pressed("move_left"):
		move_direction.x = -1
	elif event.is_action_just_pressed("move_right"):
		move_direction.x = 1

	if move_direction != Vector2.ZERO:
		_do_hop(move_direction)

func _do_hop(direction):
	is_moving = true
	var target_position = position + direction * GRID_SIZE

	# Update score ONLY on forward movement
	if direction.y < 0:
		score += 1
		score_updated.emit(score)

	# A Tween makes the hop smooth instead of instant
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE) # Gives a nice bounce effect
	tween.tween_property(self, "position", target_position, 0.15) # 0.15 second hop
	await tween.finished
	is_moving = false
