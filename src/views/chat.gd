extends AppView
const CHAT_BUBBLE = preload("uid://c0yq8ufwmamwo")

var conversation: Conversation
var bubbles: Dictionary[Message, Control]

func _ready() -> void:
	%BackButton.pressed.connect(func(): 
		AppState.current_chat = null
		AppState.back())
	
	switched_to.connect(func():
		if conversation != AppState.current_chat:
			if conversation != null:
				if conversation.updated.is_connected(messages_updated):
					conversation.updated.disconnect(messages_updated)
		
			conversation = AppState.current_chat
			conversation.updated.connect(messages_updated)
		%ChatInput.grab_focus())
	
	%SendButton.pressed.connect(send)
	
func _process(_delta: float) -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
		size.y = get_viewport_rect().size.y - (DisplayServer.virtual_keyboard_get_height() / get_viewport_transform().get_scale().y)
		position = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if %ChatInput.has_focus() and event.is_action_pressed("ui_text_submit"):
		send()

func messages_updated() -> void:
	for msg in conversation.messages:
		if msg not in bubbles:
			var bubble = CHAT_BUBBLE.instantiate()
			bubble.message = msg
			%ChatContents.add_child(bubble)
			bubbles[msg] = bubble
			
	get_tree().create_timer(0.1).timeout.connect(func(): 
		%ChatScrollContainer.set_deferred("scroll_vertical", %ChatScrollContainer.get_v_scroll_bar().max_value))

func send() -> void:
	if len(%ChatInput.text) < 1: return
	conversation.send(%ChatInput.text)
	%ChatInput.clear()
	%ChatInput.grab_focus()
