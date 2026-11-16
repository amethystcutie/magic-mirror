class_name AppView
extends Control

@export var view: AppState.View

signal switched_to
signal switched_from

func _enter_tree() -> void:
	AppState.views[view] = self
