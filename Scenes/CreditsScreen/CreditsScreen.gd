extends Control

func _on_CreditsScreen_visibility_changed():
	$VBoxContainer/HBoxContainer/Label2.text = str(ScoreManager.get_score())
