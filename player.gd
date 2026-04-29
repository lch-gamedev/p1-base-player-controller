extends CharacterBody2D

@export var speed = 400.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	

	move_and_slide()
