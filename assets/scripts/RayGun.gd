extends Sprite2D

@export var RedLaser: PackedScene
@export var BlueLaser: PackedScene
@export var laser_speed = 400.0
@export var max_rotation = PI / 2

var initial_rotation = 0.0
var is_facing_right = true

func _process(_delta):
	
	#mouse to ray gun movement
	var direction = get_global_mouse_position() - global_position
	
	var angle = direction.angle()
	if not is_facing_right:
		rotation = -angle
	else:
		rotation = angle
	
	#rotation limiter
	rotation = direction.angle()

	# Fire laser based on mouse button input
	if Input.is_action_just_pressed("mouse_right"):
		fire_laser(RedLaser)
	elif Input.is_action_just_pressed("mouse_left"):
		fire_laser(BlueLaser)

func fire_laser(laser_scene: PackedScene):
	# Create an instance of the laser and add it to the scene
	var laser = laser_scene.instantiate()
	laser.global_position = global_position
	get_tree().root.get_node("Level_1").add_child(laser)  

	# Set the laser direction to the mouse direction
	var laser_direction = Vector2(cos(rotation), sin(rotation))
	
	if not is_facing_right:
		laser_direction = -laser_direction  # Invert the direction when facing left
	
	laser.rotation = rotation
	laser.set("velocity", laser_direction * laser_speed)
	
