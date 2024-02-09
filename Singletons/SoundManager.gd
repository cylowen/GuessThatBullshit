extends Node

const SOUNDS = {
	BUTTON_CLICK = preload("res://Assets/Music/button click.wav"),
	TICKING_ANSWER = preload("res://Assets/Music/clock ticking_answer time.wav"),
	QUIZ_OPENING = preload("res://Assets/Music/Game quiz opening theme.wav"),
	QUIZ_CLOSING = preload("res://Assets/Music/Game quiz closing theme.wav"),
	RIGHT_ANSWER = preload("res://Assets/Music/right answer aound.wav"),
	WRONG_ANSWER = preload("res://Assets/Music/wrong answer sound_v2.wav")
}

func play_sound(player: AudioStreamPlayer, key: String) -> void:
	if !SOUNDS.has(key):
		print("sound found")
		return
	else:
		if player.playing:
			player.stop()
		player.stream = SOUNDS[key]
		player.play()
		

func stop_player(player: AudioStreamPlayer) -> void:
	player.stop()
