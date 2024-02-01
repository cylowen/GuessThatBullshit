extends Node


const BUTTON_CLICK = "click"
const TICKING_ANSWER = "ticking"
const QUIZ_OPENING = "opening"
const QUIZ_CLOSING = "closing"
const RIGHT_ANSWER = "right"
const WRONG_ANSWER = "wrong"

const SOUNDS = {
	BUTTON_CLICK = preload("res://Assets/Music/button click.wav"),
	TICKING_ANSWER = preload("res://Assets/Music/clock ticking_answer time.wav"),
	QUIZ_OPENING = preload("res://Assets/Music/Game quiz opening theme.wav"),
	QUIZ_CLOSING = preload("res://Assets/Music/Game quiz closing theme.wav"),
	RIGHT_ANSWER = preload("res://Assets/Music/right answer aound.wav"),
	WRONG_ANSWER = preload("res://Assets/Music/wrong answer sound_v2.wav")
}

func play_sound(player: AudioStreamPlayer, key: String) -> void:
	print("change sound")
	if !SOUNDS.has(key):
		print("not found")
		return
	else:
		player.stop()
		player.stream = SOUNDS[key]
		print("play!?")
		player.play()
		
