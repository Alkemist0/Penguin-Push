extends AudioStreamPlayer2D

@export var sounds : Array[AudioStreamWAV] = []

func _ready() -> void:
	print_debug(sounds.size())
func play_sound() :
	stream = sounds[randi_range(0, sounds.size() - 1)]
	play()