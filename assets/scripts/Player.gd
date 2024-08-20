extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 400
@export var health = 1
@export var lives = 3
@export var respawn_position: Vector2

@export_file("*.tscn") var game_over_scene
@onready var animated_sprite = $"Player Sprite"
@onready var ray_gun = $"RayGun"
@onready var health_display = $Health

func _ready():
	add_to_group("Player")
	respawn_position = global_position  
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		lives -= 1
		print("Lives left: ", lives)
		if lives > 0:
			respawn()
		else:
			game_over()
			
func respawn():
	health = 1  
	global_position = respawn_position
	print("Player respawned at: ", respawn_position)
	health_display.update_health_display()
	
func game_over():
	get_tree().change_scene_to_file(game_over_scene)
	
func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction == 1:
		animated_sprite.play("idle_right")
		ray_gun.scale.x = 1
		ray_gun.position.x = 5.5
		
	elif horizontal_direction == -1:
		animated_sprite.play("idle_left")
		ray_gun.scale.x = -1
		ray_gun.position.x = -5.5
		
	move_and_slide()
