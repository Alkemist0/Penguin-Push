extends CharacterBody2D

var flipped = false
@export var move_speed = 200
@export var gravity_modifier = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if(!is_on_floor()) :
		velocity += get_gravity() * gravity_modifier * delta
	
	if(is_on_wall() && is_on_floor()) :
		flipped = !flipped
		$Sprite2D.flip_h = flipped
	
	if(flipped) :
		velocity.x = move_speed
	else :
		velocity.x = -move_speed
	
	move_and_slide()
	
	#ANIMATIONS
	if(is_on_floor()) :
		$AnimationPlayer.play("Walk")
	else :
		$AnimationPlayer.play("Fall")
