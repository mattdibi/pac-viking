extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


func start(pos):
	position = pos
	show()
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_area_entered(area):
	if (area.has_method("add_coin")):
		area.add_coin()
		queue_free()
