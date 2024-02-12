extends Node2D


func set_button_text(text: String, button_name:String) -> void:
	if button_name == "orange_button":
		$Timer/Label2.text = text
	if button_name == "blue_button":
		$HostGame/Label.text = text
	if button_name == "green_button":
		$JoinGame/Label.text = text

func get_button_text(button_name:String) -> String:
	if button_name == "orange_button":
		return $Timer.get_node("Label2").text
	if button_name == "blue_button":
		return $HostGame.get_node("Label").text
	if button_name == "green_button":
		return $JoinGame.get_node("Label").text
	
	push_error("Button not found: %s" % button_name)
	return ""

func set_button_clickability(clickability: bool, button_name:String) -> void:
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

func _on_HostGame_pressed():
	SignalManager.emit_signal("on_blue_button_pressed")


func _on_JoinGame_pressed():
	SignalManager.emit_signal("on_green_button_pressed")
