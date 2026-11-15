extends Control

@export var views: Dictionary[AppState.View, Control]

func switch(from: AppState.View, to: AppState.View, back := false) -> void:
	print(AppState.current_screen)
	print(AppState.prev_screen)
	print(from)
	print(to)
	
	if to == AppState.View.QUIT:
		get_tree().quit()
		
	clear()
	
	if back:
		move(views[from], %NextView)
		move(views[to], %CurrentView)
		$AnimationPlayer.play_backwards("slide_next")
	else:
		move(views[from], %CurrentView)
		move(views[to], %NextView)
		$AnimationPlayer.play("slide_next")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		switch(AppState.current_screen, AppState.prev_screen, false)

func _ready() -> void:
	AppState.view_changed.connect(switch)
	clear()
	
	move(views[AppState.current_screen], %CurrentView)

func move(node: Control, to: Control) -> void:
	if node.get_parent() == null:
		to.add_child(node)
		node.position = Vector2.ZERO
	else:
		node.reparent(to)
		node.position = Vector2.ZERO

func clear() -> void:
	for child in %CurrentView.get_children(): move(child, %Shelf)
	for child in %NextView.get_children(): move(child, %Shelf)
