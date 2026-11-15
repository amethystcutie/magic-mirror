extends Node

var prev_screen = View.QUIT
var current_screen = View.MENU

signal view_changed(from: View, to: View, back: bool)

enum View {
	QUIT,
	MENU,
	CHAT
}

func back():
	view_changed.emit(current_screen, prev_screen, true)
	current_screen = prev_screen
	prev_screen = View.QUIT

func switch(view: View):
	view_changed.emit(current_screen, view)
	prev_screen = current_screen
	current_screen = view
