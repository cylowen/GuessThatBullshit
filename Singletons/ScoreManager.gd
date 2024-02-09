extends Node

var _score: int = 0


func _ready():
	SignalManager.connect("on_point_scored", self, "on_point_scored")


func on_point_scored() -> void:
	_score += 1
	
func get_score() -> int:
	return _score

func reset() -> void:
	_score = 0
