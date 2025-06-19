extends Control

var which_mode: int = 0

@onready var children: Node2D = $Children
@onready var info: Label = $Info
@onready var draw_calls: Label = $DrawCalls

func _ready() -> void:
	DebugMenu.style = DebugMenu.Style.VISIBLE_COMPACT
	setup_labels()

func _process(_delta: float) -> void:
	draw_calls.text = str("Draw Calls: ", Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))

func setup_labels():
	# remove previous labels
	for node: Node in children.get_children():
		node.queue_free()
		
	# update godot version and renderer label
	var info_dict: Dictionary = Engine.get_version_info()
	info.text = str("Godot V", info_dict["major"], ".", info_dict["minor"], ".", info_dict["patch"], "   Renderer: ", RenderingServer.get_current_rendering_method())
	
	var win_size = DisplayServer.screen_get_size()
	win_size -= Vector2i(91,52) # make 5% smaller
	
	match which_mode:
		0: # NO SHADOWS
			for i in 1000:
				var label: Label = Label.new()
				label.text = str("Label ", i)
				label.global_position = Vector2(randf_range(0, win_size.x),randf_range(0, win_size.y))
				children.add_child(label)
		1: # FAKE SHADOWS, DRAWS 2 LABELS
			for i in 1000:
				var x: float = randf_range(0, win_size.x)
				var y: float = randf_range(0, win_size.y)

				var label_shadow: Label = Label.new()
				label_shadow.text = str("Label ", i)
				label_shadow.global_position = Vector2(x + 3,y + 3)
				label_shadow.add_theme_color_override("font_color", Color(0,0,0, 0.5))
				children.add_child(label_shadow)
				
				var label: Label = Label.new()
				label.text = str("Label ", i)
				label.global_position = Vector2(x,y)
				children.add_child(label)
		2: # DEFAULT GODOT LABELS, WITH SHADOWS ENABLED
			for i in 1000:
				var label: Label = Label.new()
				label.text = str("Label ", i)
				label.global_position = Vector2(randf_range(0, win_size.x),randf_range(0, win_size.y))
				label.add_theme_constant_override("shadow_offset_x",3)
				label.add_theme_constant_override("shadow_offset_y",3)
				label.add_theme_color_override("font_shadow_color", Color(0,0,0, 0.5))
				children.add_child(label)
		3: # DEFAULT GODOT LABELS, WITH SHADOWS AND OUTLINE ENABLED
			for i in 1000:
				var label: Label = Label.new()
				label.text = str("Label ", i)
				label.global_position = Vector2(randf_range(0, win_size.x),randf_range(0, win_size.y))
				label.add_theme_constant_override("shadow_offset_x",3)
				label.add_theme_constant_override("shadow_offset_y",3)
				label.add_theme_constant_override("outline_size",3)
				label.add_theme_color_override("font_shadow_color", Color(0,0,0, 0.5))
				label.add_theme_color_override("font_outline_color", Color(1,0,0, 1))
				children.add_child(label)

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		get_tree().quit()

func _on_has_shadow_item_selected(index: int) -> void:
	which_mode = index
	setup_labels()
