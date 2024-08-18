extends RigidBody2D

@export var push_force = 500.0
var size = 1.0

func _ready() -> void:
	change_size(4)

func _process(_delta: float) -> void:
	$PushLeft.global_rotation_degrees = 0
	$PushRight.global_rotation_degrees = 0
	
	if($PushLeft.has_overlapping_bodies()) :
		linear_velocity.x = -push_force / size
	if($PushRight.has_overlapping_bodies()) :
		linear_velocity.x = push_force / size
	
	#$AnimatableBody2D.global_rotation_degrees = 0
	$AnimatableBody2D.global_position = position

func change_size(new_size : int) :
	$AnimationPlayer.play("Size" + str(new_size))
	size = new_size
