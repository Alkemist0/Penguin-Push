extends CharacterBody2D

const gravity_modifier = 2
const speed = 500
const jump_velocity = -1000.0


func _physics_process(delta: float) -> void :
	# Add the gravity.
	if(not is_on_floor()) :
		velocity += get_gravity() * gravity_modifier * delta

	# Handle jump.
	if(Input.is_action_just_pressed("Jump") and is_on_floor()) :
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if(direction) :
		velocity.x = direction * speed
	else :
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
