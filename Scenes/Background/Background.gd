extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_button_text(text: String, button_name:String) -> void:
	if button_name == "orange_button":
		$Timer/Label2.text = text
	if button_name == "blue_button":
		$HostGame/Label.text = text
	if button_name == "green_button":
		$JoinGame/Label.text = text

func set_button_clickability(clickability: bool, button_name:String) -> void:
	#if button_name == "orange_button":
	#	$Timer.mouse_filter = MOUSE_FILTER_IGNORE
	if button_name == "blue_button":
		if !clickability:
			$HostGame.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			$HostGame.mouse_filter = Control.MOUSE_FILTER_PASS
	if button_name == "green_button":
		if !clickability:
			$JoinGame.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			$JoinGame.mouse_filter = Control.MOUSE_FILTER_PASS

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HostGame_pressed():
	SignalManager.emit_signal("on_blue_button_pressed")


func _on_JoinGame_pressed():
	SignalManager.emit_signal("on_green_button_pressed")
