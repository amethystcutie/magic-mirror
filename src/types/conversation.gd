class_name Conversation
extends Node

@export var contact: Contact
@export var messages: Array[Message] = []

signal updated

func add_message(sender: int, text: String) -> void:
	var message = Message.new()
	message.sender = sender
	message.text = text
	messages.append(message)
	updated.emit()

func send(text: String) -> void:
	add_message(-1, text)
	
	var clean_text = text.strip_edges().to_lower()
	
	if clean_text.begins_with("ping"):
		recieve(str("pong! ", " ".join(text.strip_edges().split(" ").slice(1))))
	elif clean_text.contains("time"):
		recieve(str(Time.get_time_dict_from_system()))
	
func recieve(text: String) -> void:
	add_message(contact.id, text)

static func with(c: Contact) -> Conversation:
	var conversation := Conversation.new()
	conversation.contact = c
	return conversation
