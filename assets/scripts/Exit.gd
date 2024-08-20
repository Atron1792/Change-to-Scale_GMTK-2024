extends Area2D

@export_file("*.tscn") var win_screen : String

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Static Environments")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(win_screen)
