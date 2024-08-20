extends CanvasLayer

@export var heart_texture: Texture2D
@export var heart_spacing: float = 10.0

@onready var player = get_parent()  # Accessing the parent node (Player) directly

var hearts = []

func _ready():
	# Initialize the health display
	update_health_display()

func update_health_display():
	# Clear existing hearts
	for heart in hearts:
		heart.queue_free()
	hearts.clear()

	# Create hearts based on player's lives
	var lives = player.lives
	var total_hearts = lives

	for i in range(total_hearts):
		var heart = TextureRect.new()
		heart.texture = heart_texture
		heart.rect_size = heart_texture.get_size()  # Use rect_size to set size
		heart.rect_position = Vector2(i * (heart.rect_size.x + heart_spacing), 0)
		add_child(heart)
		hearts.append(heart)

	# Position hearts at the top left of the screen
	position_hearts()

func position_hearts():
	# Position the hearts at the top left of the screen
	for i in range(hearts.size()):
		hearts[i].rect_position = Vector2(10 + i * (hearts[i].rect_size.x + heart_spacing), 10)  # Adjust the position as needed
