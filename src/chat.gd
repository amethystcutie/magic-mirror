extends Control

func _ready() -> void:
	%Button.pressed.connect(func(): AppState.back())
