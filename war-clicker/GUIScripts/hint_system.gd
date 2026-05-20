extends Control

var hint_count : int = 0

var hint_texts : Dictionary = { 1: "This is Hint 1", 2: "This is Hint 2", 3: "This is Hint 3"} 


func _on_hint_timer_timeout() -> void:
	if %HintBox.visible:
		
		%HintBox.hide()
	else:
		_get_hint_text()
		%HintBox.show()
		
func _get_hint_text():
	%HintBox.text = hint_texts[randi_range(1,3)]
