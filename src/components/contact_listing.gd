extends PanelContainer

@export var contact: Contact

func _ready() -> void:
	%Button.pressed.connect(func(): 
		AppState.current_chat = Conversation.with(contact)
		AppState.switch(AppState.View.CHAT))
	
	%NameLabel.text = contact.name
	%DescLabel.text = str(contact.id)
	%ProfilePic.texture = contact.picture
