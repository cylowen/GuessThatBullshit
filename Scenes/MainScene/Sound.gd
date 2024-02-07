extends AudioStreamPlayer


func _ready():
	# Connect the finished signal to the _on_audio_finished method
	connect("finished", self, "_on_audio_finished")
	# Start playing the audio
	play()

func _on_audio_finished():
	# This function is called when the audio finishes playing
	# Restart the playback to loop the audio
	play()
