extends AudioStreamPlayer

export var music_stream : AudioStream

var closing_music
var ticking_music

func _ready():
	closing_music = preload("res://Assets/Music/Game quiz closing theme.wav")
	ticking_music = preload("res://Assets/Music/clock ticking_answer time.wav")

	#MusicPlayer.play()
	
func play_music(track):
	if track == "closing_music":
		stream = closing_music
		playing = true
	if track == "ticking_music":
		stream = ticking_music
		playing = true





