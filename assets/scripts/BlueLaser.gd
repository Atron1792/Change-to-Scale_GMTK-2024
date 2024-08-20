extends Area2D

@export var enlarge_factor = 1.2
@export var velocity: Vector2 = Vector2.ZERO

func _ready():
	#timer
	$RemovalTimer.wait_time = 1
	$RemovalTimer.start()
	
func _on_removal_timer_timeout():
	queue_free()
	
func _process(delta):
	global_position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("Dynamic Environments"):
		body.scale *= enlarge_factor
		queue_free()

	if body.is_in_group("Static Environments"):
		queue_free()
