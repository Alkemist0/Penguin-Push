extends StaticBody2D

@export var launch_force = -1000

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass

func _on_snowball_detector_area_entered(area: Area2D) -> void:
	area.get_parent().change_size(area.get_parent().size - 1)
	area.get_parent().linear_velocity.y = launch_force
	$AnimationPlayer.play("Open")
	$BounceSound.play_sound()
