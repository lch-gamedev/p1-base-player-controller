extends CharacterBody2D

@export var speed = 400.0
enum State {IDLE, WALK, ATTACK}
var current_state = State.IDLE

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	match current_state:
		State.IDLE:
			velocity = Vector2.ZERO
			if direction != Vector2.ZERO:
				current_state = State.WALK
			if Input.is_action_just_pressed("attack"):
				current_state = State.ATTACK

		State.WALK:
			velocity = direction * speed
			if direction == Vector2.ZERO:
				current_state = State.IDLE
			if Input.is_action_just_pressed("attack"):
				current_state = State.ATTACK

		State.ATTACK:
			velocity = Vector2.ZERO 

	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

	match current_state:
		State.IDLE:
			sprite.play("idle")
		State.WALK:
			sprite.play("walk")
		State.ATTACK:
			sprite.play("attack")

func _on_animated_sprite_2d_animation_finished():
	if current_state == State.ATTACK:
		current_state = State.IDLE
