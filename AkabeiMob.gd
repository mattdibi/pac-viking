extends KinematicBody2D

var speed = 300
onready var player = get_parent().get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func start(pos):
	position = pos
	show()
	$AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# Retrieve player direction
	var dir = (player.global_position - global_position).normalized()
	# If player is powered up run away from him
	if player.powered_up:
		dir = -dir
	
	# Using move_and_slide.
	var velocity = move_and_slide(dir * speed)
	
	# Animation
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk_right"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y > 0:
		$AnimatedSprite.animation = "walk_front"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "walk_back"
	else:
		$AnimatedSprite.animation = "idle"
