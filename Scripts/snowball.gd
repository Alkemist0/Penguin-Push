extends RigidBody2D

@export var push_force = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PushLeft.global_rotation_degrees = 0
	$PushRight.global_rotation_degrees = 0
	$AnimatableBody2D.global_rotation_degrees = 0
	$AnimatableBody2D.global_position = position
	
	if($PushLeft.has_overlapping_bodies()) :
		linear_velocity.x = -push_force
	if($PushRight.has_overlapping_bodies()) :
		linear_velocity.x = push_force
