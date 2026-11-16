class_name ChatBubble
extends Control

@export var message: Message

func _ready() -> void:
	if message.sender == -1:
		%YourLabel.text = message.text
		%OtherBubble.hide()
		%YourBubble.show()
	else:
		%OtherLabel.text = message.text
		%YourBubble.hide()
		%OtherBubble.show()
