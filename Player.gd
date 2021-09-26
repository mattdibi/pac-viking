extends KinematicBody2D

# Declare member variables here.
const NORMAL_SPEED = 250  # How fast the player will move (pixels/sec).
const PWRUP_SPEED  = 350  # How fast the player will move when powered up (pixels/sec).
var screen_size  # Size of the game window.
var coins = 0 # Player score
var powered_up = false # Power up state

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
		var local_speed = NORMAL_SPEED
		if powered_up:
			local_speed = PWRUP_SPEED
		velocity = velocity.normalized() * local_speed
	
	# Using move_and_slide.
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.name)
	
	# Screen wrapping
	# FIXME: Get map size instead of using constants
	# FIXME: This constants were used in the Camera2D too
	position.x = wrapf(position.x, 0, 1600)
	position.y = wrapf(position.y, 0, 1600)

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
	$PowerUpTimer.start()
	print("Power up")

func _on_PowerUpTimer_timeout():
	powered_up = false
	print("Power down")
