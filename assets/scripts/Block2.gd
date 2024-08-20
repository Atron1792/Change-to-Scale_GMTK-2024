extends Sprite2D

@export var max_size: Vector2 = Vector2(300, 300) 
@export var min_size: Vector2 = Vector2(50, 50)    
@export var enlarge_factor = 1.2
@export var shrink_factor = 0.8

@onready var texture_size = $Sprite2D.texture.get_size()

func _ready():
	add_to_group("Dynamic Environments")
	
func _check_size():
	
	var max_scale = Vector2(max_size.x / texture_size.x, max_size.y / texture_size.y)
	var min_scale = Vector2(min_size.x / texture_size.x, min_size.y / texture_size.y)
	
	scale.x = clamp(scale.x, min_scale.x, max_scale.x)
	scale.y = clamp(scale.y, min_scale.y, max_scale.y)
	
	print("New Scale: ", scale)  # Debug print

func _on_body_entered(body):
	if body.is_in_group("Lasers"):
		if body.is_in_group("RedLaser"):
			print("red")
			_on_red_laser_hit()
		elif body.is_in_group("BlueLaser"):
			print("blue")
			_on_blue_laser_hit()
		queue_free()
		print("Laser hit detected")  # Debug print

func _on_red_laser_hit():
	if scale.x < max_size.x / texture_size.x and scale.y < max_size.y / texture_size.y:
		scale *= enlarge_factor
		_check_size()
		print("Red laser hit: Enlarging") 
	
func _on_blue_laser_hit():
	scale *= shrink_factor
	_check_size()
	print("Blue laser hit: Shrinking")  # Debug print
