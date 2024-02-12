extends Control

var question_pool = []
const NUMBER_OF_QUESTIONS = 7
var remaining_questions
var parsed_json
var current_question
const FILE_PATH = "res://Assets/0207csvjson.json"

var question_pool_size: int = 0

func _ready():
	SignalManager.connect("questions_started", self, "_questions_started")
	var file = File.new()
	var error = file.open(FILE_PATH, File.READ)
	if error == OK: # Read the entire content of the file
		var file_text = file.get_as_text() # Close the file
		file.close()
		parsed_json = JSON.parse(file_text)
		question_pool_size = parsed_json.result.size()
	else:
		printerr("An error occured when loading %s: %d" % [FILE_PATH, error])
	reset_scene()
	

func _process(delta):
	$Timer/Label2.text = str(round($QuestionTimer.time_left))


func _questions_started():
	_get_new_question()
	
	
func _get_new_question():
	$ProgressLabel.text = str(NUMBER_OF_QUESTIONS - remaining_questions + 1) + "/" + str(NUMBER_OF_QUESTIONS)
	remaining_questions -= 1
	# Get a random index
	randomize()
	var random_index = randi() % question_pool.size()
	# Get the random element from the array
	current_question = question_pool[random_index]
	question_pool.remove(random_index)
	_display_new_question()
	$QuestionTimer.start()
	$Timer/Label.visible = true
	$Timer/Label2.visible = true
	set_process(true)
	
	
func _display_new_question():
	SignalManager.emit_signal("on_question_shown")
	$QuestionLabel.text = parsed_json.result[current_question]["question"]
	$AnswersContainer.visible = true
	$AnswersContainer/AnswerButton1.text = parsed_json.result[current_question]["answer1"]
	$AnswersContainer/AnswerButton2.text = parsed_json.result[current_question]["answer2"]
	$AnswersContainer/AnswerButton3.text = parsed_json.result[current_question]["answer3"]
	
func _on_Timer_timeout():
	SoundManager.play_sound($QuipSounds, "WRONG_ANSWER")
	_display_answer()
		
func _display_answer():
	set_process(false)
	SignalManager.emit_signal("on_answer_given")
	$ProgressLabel.text = ""
	$Timer/Label2.visible = false
	$Timer/Label.visible = false
	$QuestionLabel.text = parsed_json.result[current_question]["message"]
	$AnswersContainer.visible = false
	$ContinueButton.visible = true


func _on_answer_given():
	_display_answer()
	$QuestionTimer.stop()
	
func _on_ContinueButton_pressed():
	SoundManager.play_sound($QuipSounds, "BUTTON_CLICK")
	_get_new_questions()
		
func _get_new_questions():
	$ContinueButton.visible = false
	if remaining_questions > 0:
		_get_new_question()
	else:
		SignalManager.emit_signal("on_game_ended")
		
func reset_scene():
	set_process(false)
	$ContinueButton.visible = false
	remaining_questions = NUMBER_OF_QUESTIONS
	if question_pool.size() >= remaining_questions:
		return
	else:
		question_pool = []
		for number in range(question_pool_size):
			question_pool.append(number)

func _on_AnswerButton1_pressed():
	_check_for_correct_answer(1)
	_on_answer_given()

func _on_AnswerButton2_pressed():
	_check_for_correct_answer(2)


func _on_AnswerButton3_pressed():
	_check_for_correct_answer(3)

func string_to_array_of_integers(s: String) -> Array:
	var result = []
	# Check if the variable is a string
	if typeof(s) == TYPE_STRING:
		# Split the string by commas and convert each substring to an integer
		var substrings = s.split(",")
		for substring in substrings:
			result.append(int(substring))
	return result

func play_quip_sounds(correct_answer: bool):
	if correct_answer:
		SoundManager.play_sound($QuipSounds, "RIGHT_ANSWER")
		SignalManager.emit_signal("on_point_scored")
	else:
		SoundManager.play_sound($QuipSounds, "WRONG_ANSWER")

func _check_for_correct_answer(given_answer_id):
	var right_answer = parsed_json.result[current_question]["correct"]
	if typeof(right_answer) == TYPE_STRING:
		var right_answers = string_to_array_of_integers(right_answer)
		var rightAnswerExists = false
		for answer in right_answers:
			if answer == given_answer_id:
				rightAnswerExists = true
		play_quip_sounds(rightAnswerExists)
	else:
		play_quip_sounds(right_answer == given_answer_id)
	_on_answer_given()
