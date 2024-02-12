extends Node2D

func _ready():
	SignalManager.connect("on_blue_button_pressed", self, "_get_blue_button_signal")
	SignalManager.connect("on_green_button_pressed", self, "_get_green_button_signal")
	SignalManager.connect("questions_started", self, "_show_questions")
	SignalManager.connect("on_game_ended", self, "_show_credits")
	SignalManager.connect("on_answer_given", self, "on_answer_given")
	SignalManager.connect("on_question_shown", self, "on_question_shown")
	_button_config()
	SoundManager.play_sound($Sound, "QUIZ_OPENING")
	
func _get_blue_button_signal():
	if ($Background.get_button_text("blue_button") == "Start Game"):
		SoundManager.play_sound($QuipSounds, "BUTTON_CLICK")
		SignalManager.emit_signal("questions_started")
	else:
		_reset_game()

func _get_green_button_signal():
	SoundManager.play_sound($QuipSounds, "BUTTON_CLICK")
	SoundManager.toggle_mute()
	$Background.set_button_text("Sound %s" % ("Off" if SoundManager.is_mute() else "On"), "green_button")
	
func on_answer_given():
	SoundManager.stop_player($Sound)
	
func on_question_shown():
	SoundManager.play_sound($Sound, "TICKING_ANSWER")
	
func _show_questions():
	SoundManager.play_sound($Sound, "TICKING_ANSWER")
	$QuestionScreen.visible = true
	$StartScreen.visible = false
	$Background.set_button_text("", "blue_button")
	$Background.set_button_clickability(false, "blue_button")

func _show_credits():
	SoundManager.play_sound($Sound, "QUIZ_CLOSING")
	$QuestionScreen.visible = false
	$CreditsScreen.visible = true
	$Background.set_button_text("Home", "blue_button")
	$Background.set_button_clickability(true, "blue_button")

func _reset_game():
	$QuestionScreen.reset_scene()
	$CreditsScreen.visible = false
	$StartScreen.visible = true
	_button_config()
	SoundManager.play_sound($Sound, "QUIZ_OPENING")
	ScoreManager.reset()
	
func _button_config():
	$Background.set_button_text("Sound %s" % ("Off" if SoundManager.is_mute() else "On"), "green_button")
	$Background.set_button_clickability(true, "green_button")
	$Background.set_button_text("Start Game", "blue_button")
	$Background.set_button_clickability(true, "blue_button")
