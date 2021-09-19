extends KinematicBody2D

# Declare member variables here.
export var speed = 200  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var coins = 0 # Player score
var powered_up = false # Power up state

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	
	# Using move_and_collide.
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I collided with ", collision.collider.name)
	
	# Animation
	if not powered_up:
		if velocity.x != 0:
			$AnimatedSprite.animation = "run_left"
			$AnimatedSprite.flip_v = false
			# See the note below about boolean assignment
			$AnimatedSprite.flip_h = velocity.x > 0
		elif velocity.y > 0:
			$AnimatedSprite.animation = "run_front"
		elif velocity.y < 0:
			$AnimatedSprite.animation = "run_back"
		else:
			$AnimatedSprite.animation = "idle"
	else:
		if velocity.x != 0:
			$AnimatedSprite.animation = "power_right"
			$AnimatedSprite.flip_v = false
			# See the note below about boolean assignment
			$AnimatedSprite.flip_h = velocity.x < 0
		elif velocity.y > 0:
			$AnimatedSprite.animation = "power_front"
		elif velocity.y < 0:
			$AnimatedSprite.animation = "power_back"
		else:
			$AnimatedSprite.animation = "power_idle"
	
func start(pos):
	position = pos
	show()
	$AnimatedSprite.play()
	
func add_coin():
	coins += 1
	print("Coins: ", coins)

func power_up():
	powered_up = true
	print("Power up")
