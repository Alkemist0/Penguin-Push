extends RigidBody2D

@export var push_force = 15.0
var size = 1.0

func _ready() -> void:
	change_size(1)

func _physics_process(_delta: float) -> void:
	$PushLeft.global_rotation_degrees = 0
	$PushRight.global_rotation_degrees = 0
	
	if($PushLeft.has_overlapping_bodies()) :
		angular_velocity= -push_force / size
	if($PushRight.has_overlapping_bodies()) :
		angular_velocity = push_force / size
		
	$AnimatableBody2D.global_position = global_position
	$EnemyDetector.global_position = global_position

func change_size(new_size : int) :
	if(new_size > 4) : return
	if(new_size < 1) : 
		queue_free()
		return
	$AnimationPlayer.play("Size" + str(new_size))
	size = new_size
	mass = size * 100

func _on_enemy_detector_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Snowball_Enemy")) :
		body.queue_free()
		change_size(size + 1)
