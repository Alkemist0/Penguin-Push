extends Node2D

@export var wind_force = -10
@export var move_speed = 10
var moving_up = true

func _process(delta: float) -> void :
	if(moving_up) :
		position.y = move_toward(position.y, -350, delta * move_speed)
		if(position.y <= -350) :
			moving_up = false
	else :
		position.y = move_toward(position.y, 350, delta * move_speed)
		if(position.y >= 350) :
			moving_up = true

func _physics_process(_delta: float) -> void :
	for body in $Area2D.get_overlapping_bodies() :
		if(body is CharacterBody2D) :
			body.velocity.x += wind_force
		elif(body is RigidBody2D) :
			body.linear_velocity.x += wind_force
