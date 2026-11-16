extends Node

var prev_screen = View.QUIT
var current_screen = View.MENU

signal view_changed(from: View, to: View, back: bool)

var current_chat: Conversation = null

enum View {
	QUIT,
	MENU,
	CHAT
}

@export var views: Dictionary[View, AppView]

func back():
	view_changed.emit(current_screen, prev_screen, true)
	views[current_screen].switched_from.emit()
	current_screen = prev_screen
	prev_screen = View.QUIT

func switch(view: View):
	if view == View.QUIT: get_tree().quit()
	
	view_changed.emit(current_screen, view)
	prev_screen = current_screen
	current_screen = view
	
	views[prev_screen].switched_from.emit()
	views[current_screen].switched_to.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"): back()

func get_view(view: View) -> AppView:
	if view == View.QUIT: return null
	
	while !views.has(view):
		await get_tree().process_frame
	
	return views[view]
