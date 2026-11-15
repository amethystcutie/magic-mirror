extends PanelContainer

func _ready() -> void:
	%Button.pressed.connect(func(): AppState.switch(AppState.View.CHAT))
