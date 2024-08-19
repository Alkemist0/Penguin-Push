extends CharacterBody2D

@export var gravity_modifier = 2.0
@export var speed = 1000.0
@export var jump_velocity = -1000.0
@export var slippery = 40.0
@export var camera : Camera2D
#@export var camera_speed = 20
var coyote_time = false
var last_floor = false
var jump_buffer

func _physics_process(delta: float) -> void :
	# Add the gravity.
	if(!is_on_floor()) :
		velocity += get_gravity() * gravity_modifier * delta
		
	# Handle jump.
	if(Input.is_action_pressed("Jump")) :
		if(is_on_floor() || coyote_time) :
			velocity.y = jump_velocity
			coyote_time = false
		else :
			$JumpBuffer.start()
			jump_buffer = true
	
	if(jump_buffer && is_on_floor()) :
		velocity.y = jump_velocity
		coyote_time = false
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if(direction) :
		velocity.x = move_toward(velocity.x, direction * speed, speed/slippery)
	else :
		velocity.x = move_toward(velocity.x, 0, speed/slippery)
	
	#Flip sprite if facing other direction
	if(velocity.x > 0) :
		$Sprite2D.flip_h = false
		$FloorChecker.scale = Vector2(1, 1)
		$SnowballChecker.scale = Vector2(1, 1)
	if(velocity.x < 0) :
		$Sprite2D.flip_h = true
		$FloorChecker.scale = Vector2(-1, 1)
		$SnowballChecker.scale = Vector2(-1, 1)
	
	
	##Move camera to be in front of player
	#if($Sprite2D.flip_h) :
		#camera.position.x = move_toward(camera.position.x, position.x - 480, camera_speed)
	#else :
		#camera.position.x = move_toward(camera.position.x, position.x + 480, camera_speed)
	camera.position.x = position.x
	
	move_and_slide()
	
	if(last_floor && !is_on_floor()) :
		coyote_time = true
		$Coyote.start()
	
	last_floor = is_on_floor()
	
	#ANIMATIONS
	if(!$FloorChecker.has_overlapping_bodies()) :
		$Sprite2D/AnimationPlayer.play("Balance")
	elif($SnowballChecker.has_overlapping_bodies()):
		$Sprite2D/AnimationPlayer.play("Push")
		$Sprite2D/AnimationPlayer.speed_scale = 1
	else:
		if(velocity.x != 0) :
			$Sprite2D/AnimationPlayer.play("Run")
			$Sprite2D/AnimationPlayer.speed_scale = velocity.x / speed
		else :
			$Sprite2D/AnimationPlayer.play("Idle")
	
	if(Input.is_action_pressed("Left") && velocity.x > 0 || Input.is_action_pressed("Right") && velocity.x < 0) :
		$Sprite2D/AnimationPlayer.play("Turn")
	
	#if($SnowballChecker.has_overlapping_bodies()) :
		#$Sprite2D/AnimationPlayer.play("Push")
		#$Sprite2D/AnimationPlayer.speed_scale = velocity.x / speed
	
	if(!is_on_floor()) :
		if(velocity.y < 0) :
			$Sprite2D/AnimationPlayer.play("Jump")
		else :
			$Sprite2D/AnimationPlayer.play("Fall")
	
	if(velocity.x == 0) :
		$Sprite2D/AnimationPlayer.speed_scale = 1

func _on_coyote_timeout() -> void:
	coyote_time = false

func _on_jump_buffer_timeout() -> void:
	jump_buffer = false
