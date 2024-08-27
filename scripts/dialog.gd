extends Panel

var dialog_text: Array[String] = []
var current_index: int = 0
var current_text_index: int = 0

func _on_text_delay_timeout() -> void:
	if current_index < dialog_text.size():
		if current_text_index < dialog_text[current_index].length():
			%Text.text = dialog_text[current_index].substr(0, current_text_index + 1)
			current_text_index += 1
		else:
			%TextDelay.stop()
			%Next.visible = true
	else:
		%TextDelay.stop()
		dialog_text = []
		current_index = 0
		current_text_index = 0
		visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pickup") && dialog_text.size() > 0:
		if current_index < dialog_text.size():
			if current_text_index == dialog_text[current_index].length() || current_text_index == 0:
				%Text.text = ""
				%TextDelay.start()
				current_text_index = 0
				current_index += 1
				%Next.visible = false
			else:
				%Text.text = dialog_text[current_index]
				current_text_index = 0
				%TextDelay.stop()
				%Next.visible = true

func start_dialog(text: Array[String]):
	dialog_text = text
	%Text.text = ""
	visible = true
	%TextDelay.start()
