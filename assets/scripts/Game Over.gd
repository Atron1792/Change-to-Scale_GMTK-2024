extends Node2D

@export_file("*.tscn") var main_menu : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_restart_pressed():
	get_tree().change_scene_to_file(main_menu)

func _on_exit_pressed():
	get_tree().quit()
