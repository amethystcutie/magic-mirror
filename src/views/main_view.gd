extends Control

func switch(from: AppState.View, to: AppState.View, back := false) -> void:
	print(AppState.current_screen)
	print(AppState.prev_screen)
	print(from)
	print(to)
	
	if to == AppState.View.QUIT:
		get_tree().quit()
		return
		
	clear()
	
	if back:
		move(AppState.views[from], %NextView)
		move(AppState.views[to], %CurrentView)
		$AnimationPlayer.play_backwards("slide_next")
	else:
		move(AppState.views[from], %CurrentView)
		move(AppState.views[to], %NextView)
		$AnimationPlayer.play("slide_next")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		switch(AppState.current_screen, AppState.prev_screen, false)

func _ready() -> void:
	AppState.view_changed.connect(switch)
	clear()
	
	move(await AppState.get_view(AppState.current_screen), %CurrentView)

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

func _process(delta: float) -> void:
	var gradient: Gradient = $Wallpaper.texture.gradient
	if AppState.current_chat:
		gradient.set_color(0, gradient.get_color(0).lerp(AppState.current_chat.contact.colour, delta * 3))
	else:
		gradient.set_color(0, gradient.get_color(0).lerp(gradient.get_color(1), delta * 7))
