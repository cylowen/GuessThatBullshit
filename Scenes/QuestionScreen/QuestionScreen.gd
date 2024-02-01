extends Control

var question_pool = []
const NUMBER_OF_QUESTIONS = 5
var remaining_questions
var parsed_json
var current_question
#Path to the question JSON
var file_path = "res://Assets/csvjson.json"
var question_pool_size: int = 0

func _ready():
	SignalManager.connect("questions_started", self, "_questions_started")
	var file = File.new()
	if file.open(file_path, File.READ) == OK: # Read the entire content of the file
		var file_text = file.get_as_text() # Close the file
		file.close()
		parsed_json = JSON.parse(file_text)
		#example
		#print(parsed_json.result)
		#question_pool_size = parsed_json.result["questions"].size()
		question_pool_size = parsed_json.result.size()
	reset_scene()
	

func _process(delta):
	$Timer/Label2.text = str(round($QuestionTimer.time_left))


func _questions_started():
	_get_new_question()
	
	
func _get_new_question():
	remaining_questions -= 1
	# Get a random index
	randomize()
	var random_index = randi() % question_pool.size()
	# Get the random element from the array
	current_question = question_pool[random_index]
	question_pool.remove(random_index)
	print(current_question)
	_display_new_question()
	$QuestionTimer.start()
	$Timer/Label2.visible = true
	set_process(true)
	
	
func _display_new_question():
	$QuestionLabel.text = parsed_json.result[current_question]["question"]
	#$QuestionLabel.text = parsed_json.result["questions"][current_question]["question"]
	$AnswersContainer.visible = true
	#$AnswersContainer/AnswerButton1.text = parsed_json.result["questions"][current_question]["answer1"]
	#$AnswersContainer/AnswerButton2.text = parsed_json.result["questions"][current_question]["answer2"]
	#$AnswersContainer/AnswerButton3.text = parsed_json.result["questions"][current_question]["answer3"]
	$AnswersContainer/AnswerButton1.text = parsed_json.result[current_question]["answer1"]
	$AnswersContainer/AnswerButton2.text = parsed_json.result[current_question]["answer2"]
	$AnswersContainer/AnswerButton3.text = parsed_json.result[current_question]["answer3"]
	
func _on_Timer_timeout():
	SoundManager.play_sound($QuipSounds, "WRONG_ANSWER")
	_display_answer()
		
func _display_answer():
	set_process(false)
	$Timer/Label2.visible = false
	$QuestionLabel.text = parsed_json.result[current_question]["message"]
	#$QuestionLabel.text = parsed_json.result["questions"][current_question]["message"]
	$AnswersContainer.visible = false
	$AnswerTimer.start()
	$ContinueButton.visible = true


func _on_AnswerTimer_timeout():
	_get_new_questions()

func _on_answer_given():
	_display_answer()
	$QuestionTimer.stop()
	
func _on_ContinueButton_pressed():
	SoundManager.play_sound($QuipSounds, "BUTTON_CLICK")
	_get_new_questions()
		
func _get_new_questions():
	$ContinueButton.visible = false
	$AnswerTimer.stop()
	if remaining_questions > 0:
		_get_new_question()
	else:
		SignalManager.emit_signal("on_game_ended")
		print("game ended")
		
func reset_scene():
	set_process(false)
	$ContinueButton.visible = false
	remaining_questions = NUMBER_OF_QUESTIONS
	
	for number in range(question_pool_size):
		question_pool.append(number)
	#print(question_pool)


func _on_AnswerButton1_pressed():
	_check_for_correct_answer(1)
	_on_answer_given()

func _on_AnswerButton2_pressed():
	_check_for_correct_answer(2)


func _on_AnswerButton3_pressed():
	_check_for_correct_answer(3)


func _check_for_correct_answer(given_answer_id):
	var right_answer = parsed_json.result[current_question]["correct"]
	if right_answer == given_answer_id:
		SoundManager.play_sound($QuipSounds, "RIGHT_ANSWER")
	else:
		SoundManager.play_sound($QuipSounds, "WRONG_ANSWER")
	_on_answer_given()
